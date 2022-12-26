local Session = require("modules.multi-cursors.session")

local M = {}

-- TODO:
-- Explore alternative where we just wrap the existing text objects and set vim.v.motion (or similar)
-- and then we can, for each cursor, execute the motion and then the text object
-- this gives us less control, but allows us to reuse existing infrastructure and other plugins...
--
-- We could also have "intermediate" text objects, which execute a certain TO,
-- and then save the range marked in in Range, which we pass to the operator func

function M.operator(operator)
  return function()
    _G.operator = operator

    -- TODO: save sessions buffer-locally
    -- TODO: pass operator as string to execute_operator
    vim.go.operatorfunc = "v:lua.require'modules.multi-cursors'.execute_operator"

    return "g@"
  end
end

function M.motion(motion)
  return function()
    _G.get_session():execute_motion(motion)
  end
end

function M.operator_pending(text_object)
  return function()
    _G.text_object = text_object

    return "viw"
  end
end

function M.get_session()
  return _G.session
end

function M.execute_operator()
  M.get_session():execute_operator()
end

function M.setup()
  _G.session = Session:new()
  _G.get_session = function()
    return _G.session
  end
end

return M
