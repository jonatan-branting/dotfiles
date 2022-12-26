require("tests.test_helper")

local Session = require("modules.multi-cursors.session")
local left = require("modules.multi-cursors.motions.left")

describe("left", function()
  it("moves the given cursor 1 column to the left", function()
    setup_buffer(
      {
        "test_text_row_1",
      },
      "lua"
    )

    local session = Session:new()
    local cursor = session:add_cursor({ 1, 2 })

    left(cursor)

    assert.are.same(
      { 1, 1 },
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
    local cursor = session:add_cursor({ 1, 1 })

    left(cursor)

    assert.are.same(
      { 1, 1 },
      cursor.pos:get()
    )
  end)
end)
