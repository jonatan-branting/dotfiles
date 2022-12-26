require("tests.test_helper")

local MC = require("modules.multi-cursors")
local delete = require("modules.multi-cursors.operators.delete")
local right_motion = require("modules.multi-cursors.motions.right")
local right_text_object = require("modules.multi-cursors.text_objects.right")

describe("a multi-cursor session", function()
  before_each(function()
    setup_buffer(
      {
        "test_text_row_1",
        "test_text_row_2",
      },
      "lua"
    )

    MC.setup()

    vim.keymap.set("n", "d", MC.operator(delete), { expr = true })
    vim.keymap.set("n", "l", MC.motion(right_motion), { expr = true })
    vim.keymap.set("o", "il", MC.operator_pending(right_text_object), { expr = true })

    _G.get_session():add_cursor({ 1, 1 })
    _G.get_session():add_cursor({ 2, 1 })
  end)

  it("can move multiple cursors", function()
    vim.cmd("normal l")

    assert.are.same(
      { 1, 2 },
      _G.get_session().cursors[1].pos:get()
    )
    assert.are.same(
      { 2, 2 },
      _G.get_session().cursors[2].pos:get()
    )
  end)

  it("can execute operators on multiple cursors", function()
    vim.cmd("normal dil")

    assert.are.same("est_text_row_1", get_buf_lines()[1])
    assert.are.same("est_text_row_2", get_buf_lines()[2])
  end)
end)
