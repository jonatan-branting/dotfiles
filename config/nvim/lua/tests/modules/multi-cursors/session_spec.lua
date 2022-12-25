require("tests.test_helper")

local Spy = require('luassert.spy')

local Session = require("modules.multi-cursors.session")
local Range = require("modules.lib.range")

describe("#add_cursor", function()
  it("adds a cursor at the specified position", function()
    local session = Session:new()
    session:add_cursor({ 1, 1 })
    session:add_cursor({ 2, 1 })

    local cursor1 = session.cursors[1]
    local cursor2 = session.cursors[2]

    assert.are.same({ 1, 1 }, cursor1.pos:get())
    assert.are.same({ 2, 1 }, cursor2.pos:get())
  end)
end)


describe("#execute", function()
  before_each(function()
    setup_buffer(
      {
        "local line_1 = 1",
        "line_2 = 2",
      },
      "lua"
    )
  end)

  it("executes `operator` with the range given from the current text object for all cursors", function()
    local session = Session:new()
    session:add_cursor({ 1, 1 })
    session:add_cursor({ 2, 2 })

    -- 1 character to the right
    _G.text_object = function(cursor)
      local row, col = unpack(cursor.pos:get())
      return Range:new(
        { row, col },
        { row, col + 1 }
      )
    end

    local func = Spy.new(function(cursor) end)

    session:execute(func)

    assert.spy(func).was_called_with(
      Range:new({ 1, 1 }, { 1, 2 })
    )
    assert.spy(func).was_called_with(
      Range:new({ 2, 2 }, { 2, 3 })
    )
  end)
end)

