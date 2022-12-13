local utils = require("utils")

local M = {}

-- TODO a long string of spaces is also a word...
-- TODO W and E and B has another pattern WORD and word are different
-- TODO consider not supporting vim-wordmotion, otherwise we need to differ between word- "binders" and other word.
-- example is that in "word_motion", there are 2 words, "word" and "motion", and one binder "_"
-- whereas in WordMotion, there are only 2 words. 
--
-- word motions should not include other words in before and after, but rather only binders
--
-- i.e. there are four types, words, word-binders, whitespace, and delimiters
-- tokenize into WordWord
M.tokenization_pattern = "()(%s*)()([^a-zA-Z0-9%_%-%s]*)()([a-zA-Z0-9%-%_]*)()"

-- TODO speed up this?
local function extract_tokens(content)
  local tokens = {}
  for c, ws, i, delim, j, token, k in string.gmatch(content, M.tokenization_pattern) do
    if ws ~= "" then table.insert(tokens, {c, i, ws}) end
    if delim ~= "" then table.insert(tokens, {i, j, delim}) end
    if token ~= "" then table.insert(tokens, {j, k, token})  end
  end
  return tokens
end

local function get_buffer_content(range)
  local content = ""
  F.iter_buffer_range(0, {range[1], 1, range[1], -1},
    function(line) content = content .. line end, { linewise = false })
  return content
end

local function is_inside_word(tokens, before_col, after_col)
  for _, pos in ipairs(tokens) do
    local s, e, _ = unpack(pos)
    if s <= after_col + 1 and e > after_col +1 and s <= before_col + 1 and e > before_col + 1 then
      return true
    end
  end
  return false
end

local function get_word_range(before_row, before_col, after_row, after_col)
  local range
  if after_row == before_row then
    if after_col < before_col then
      range = { after_row, after_col + 1, before_row, before_col + 1 }
    else
      range = { before_row, before_col + 1, after_row, after_col + 1 }
    end
  elseif after_row < before_row then
    range = { after_row, after_col + 1, after_row, -1}
  elseif after_row > before_row then
    range = { after_row, 1, after_row, after_col + 1}
  else
    error("strange range".. before_row .. before_col .. after_row .. after_col, 1)
  end
  return range
end

local TestWord = 123

-- TODO passing around tokens and stuff like that makes no sense, i basically
-- just split up the file, might as well be inline by then.

local function include_end(tokens, i)
  local future = tokens[i + 1]
  local _, end_, _ = unpack(tokens[i])

  if not future then return end_ end

  local _, future_end, token = unpack(future)
  if string.match(token, "[%s_%-]+") then
    return future_end
  end

  return end_
end

local function include_beginning(tokens, i)
  local future = tokens[i - 1]
  local start, _, _ = unpack(tokens[i])

  if not future then return start end

  local future_start, _, token = unpack(future)
  if string.match(token, "[%s_%-]+") then
    return future_start
  end

  return start
end

function M.select(opts)
  local defaults = {
    end_inclusive = true,
    start_inclusive = false
  }

  local opts = utils.merge(defaults, opts or {})

  return function(before, after)
    local before_row, before_col = unpack(before)
    local after_row, after_col = unpack(after)

    local range = get_word_range(before_row, before_col, after_row, after_col)
    local content = get_buffer_content(range)
    if #content == "" then return end

    local tokens = extract_tokens(content)
    if #tokens == 0 then return end

    if is_inside_word(tokens, before_col, after_col) then
      return range
    end

    for i, pos in ipairs(tokens) do
      local s, e, _ = unpack(pos)

      -- matched a token we should select
      if s <= after_col + 1 and e > after_col + 1 then

        if opts.end_inclusive then
          e = include_end(tokens, i)
        end

        if opts.start_inclusive then
          s = include_beginning(tokens, i)
        end

        return {after_row, s, after_row, e - 1}
      end
    end

    -- if we couldn't find a match it's because it's the last not included in
    -- the gmatch due to the last empty capture group, which eats up the token
    local _, e, _ = unpack(tokens[#tokens])
    return {after_row, e, after_row, #content}
  end
end

return M
