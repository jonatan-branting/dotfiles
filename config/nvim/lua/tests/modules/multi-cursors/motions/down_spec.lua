require("tests.test_helper")

local Session = require("modules.multi-cursors.session")
local down = require("modules.multi-cursors.motions.down")

describe("down", function()
  it("moves the given cursor down 1 row", function()
    setup_buffer(
      {
        "test_text_row_1",
        "test_text_row_2",
      },
      "lua"
    )

    local session = Session:new()
    local cursor = session:add_cursor({ 1, 1 })

    down(cursor)

    assert.are.same(
      { 2, 1 },
      cursor.pos:get()
    )
  end)

  it("does not do anything if at the last", function()
    setup_buffer(
      {
        "test_text_row_1",
        "test_text_row_2",
      },
      "lua"
    )

    local session = Session:new()
    local cursor = session:add_cursor({ 2, 1 })

    down(cursor)

    assert.are.same(
      { 2, 1 },
      cursor.pos:get()
    )
  end)
end)
