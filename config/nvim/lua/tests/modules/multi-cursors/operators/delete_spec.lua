require("tests.test_helper")

local Range = require("modules.lib.range")
local delete = require("modules.multi-cursors.operators.delete")

describe("some basics", function()
  describe("single line", function()
    before_each(function()
      setup_buffer(
        {
          "local this_is_a_test = true",
        },
        "lua"
      )
    end)

    it("deletes the range from the buffer", function()
      local range = Range:new({ 1, 7 }, { 1, 11 })

      delete(range)

      local result = get_buf_lines()[1]

      assert.are.same("local is_a_test = true", result)
    end)

    it("returns the deleted content", function()
      local range = Range:new({ 1, 7 }, { 1, 11 })

      local result = delete(range)

      assert.are.same(
        {
          "this_",
        },
        result
      )
    end)
  end)

  describe("multiple lines", function()
    before_each(function()
      setup_buffer(
        {
          "local line_1 = 1",
          "line_2 = 2",
          "local line_3 = 3",
        },
        "lua"
      )
    end)

    it("deletes the range from the buffer", function()
      local range = Range:new({ 1, 13 }, { 3, 12 })

      delete(range)

      local result = get_buf_lines()[1]

      assert.equals(1, #get_buf_lines())
      assert.are.same("local line_1 = 3", result)
    end)

    it("returns thedeleted content", function()
      local range = Range:new({ 1, 13 }, { 3, 12 })

      local result = delete(range)

      assert.are.same(
        {
          " = 1",
          "line_2 = 2",
          "local line_3"
        },
        result
      )
    end)
  end)
end)
