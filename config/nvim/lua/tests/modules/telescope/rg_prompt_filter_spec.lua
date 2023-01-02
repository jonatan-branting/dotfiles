require("tests.test_helper")

local prompt_filter = require("modules.telescope.rg_prompt_filter")

describe("prompt_filter", function()
  it("converts spaces to wildcards", function()
    local prompt = "foo bar baz"

    local result = prompt_filter(prompt)

    assert.are.equal("foo.*bar.*baz.*", result)
  end)

  it("converts ! to rg syntax", function()
    local prompt = "bar !foo"

    local result = prompt_filter(prompt)

    assert.are.equal("^(?!.*foo).*bar.*", result)
  end)

  it("converts in: to rg syntax", function()
    local prompt = "bar in:foo"

    local result = prompt_filter(prompt)

    assert.are.equal("bar.* --glob **foo**", result)
  end)

  it("converts !in: to rg syntax", function()
    local prompt = "bar !in:foo"

    local result = prompt_filter(prompt)

    assert.are.equal("bar.* --iglob **foo**", result)
  end)
end)
