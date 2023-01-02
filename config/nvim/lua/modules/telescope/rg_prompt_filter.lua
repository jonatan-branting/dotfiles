local utils = require("utils")

local tokenize_string = function(str)
  local tokens = {}
  for token in str:gmatch("%S+") do
    table.insert(tokens, token)
  end

  return tokens
end

local run_extractors = function(tokens, ...)
  local extractors = {...}
  local result = utils.default_table(function() return {} end)

  for _, token in ipairs(tokens) do
    for _, extractor in ipairs(extractors) do
      local extracted = extractor(token)

      if extracted ~= nil then
        table.insert(result[extractor], extracted)

        break
      end
    end
  end

  return result
end

local function extract_excluded_term(token)
  if token:match("^!") then
    return "^(?!.*" .. token:gsub("^!", "") .. ")"
  end
end

local function extract_included_path(token)
  if token:match("^in:") then
    return token:gsub("^in:", "")
  end
end

local function extract_excluded_path(token)
  if token:match("^!in:") then
    return token:gsub("^!in:", "")
  end
end

local function extract_search_term(token)
  return token
end

local function build_str(directory, terms)
  local str = ""

  for _, word in ipairs(terms.excluded) do
    str = str .. word .. ".*"
  end

  for _, word in ipairs(terms.included) do
    str = str .. word .. ".*"
  end

  for _, dir in ipairs(directory.excluded) do
    str = str .. " --iglob **" .. dir .. "**"
  end

  for _, dir in ipairs(directory.included) do
    str = str .. " --glob **" .. dir .. "**"
  end

  return str
end

return function(prompt)
  local tokens = tokenize_string(prompt)

  local results = run_extractors(
    tokens,
    extract_excluded_path,
    extract_excluded_term,
    extract_included_path,
    extract_search_term
  )

  local directory = {
    included = results[extract_included_path],
    excluded = results[extract_excluded_path],
  }

  local terms = {
    excluded = results[extract_excluded_term],
    included = results[extract_search_term],
  }

  return build_str(directory, terms)
end
