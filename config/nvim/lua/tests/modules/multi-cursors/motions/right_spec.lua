require("tests.test_helper")

local Session = require("modules.multi-cursors.session")
local right = require("modules.multi-cursors.motions.right")

describe("right", function()
  it("moves the given cursor 1 column to the right", function()
    setup_buffer(
      {
        "test_text_row_1",
      },
      "lua"
    )

    local session = Session:new()
    local cursor = session:add_cursor({ 1, 1 })

    right(cursor)

    assert.are.same(
      { 1, 2 },
      cursor.pos:get()
    )
  end)

  it("does not do anything if at the last column", function()
    setup_buffer(
      {
        "test",
      },
      "lua"
    )

    local session = Session:new()
    local cursor = session:add_cursor({ 1, 4 })

    right(cursor)

    assert.are.same(
      { 1, 4 },
      cursor.pos:get()
    )
  end)
end)
