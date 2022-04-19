local sql = require("sqlite")
local db_path = "~/.local/share/nvim/nvim_command_history"

local function setup_db_schemas()
  sql.with_open(db_path, function(db)
    db:create("command_usages", {
        id = {"integer", "primary", "key"},
        command = "string",
        source = "string",
        ensure = true
      })
    end)
  end

-- Setup schemas if they do not exist
sql.with_open("~/.local/share/nvim/telescope_command_history", function(db)
  if not db:exists("command_usages") then
    setup_db_schemas()
  end

end)

local function insert_command(source, cmd)
  if not source or not cmd then return false end

  return sql.with_open(db_path, function(db)
    if not db:exists("command_usages") then
      setup_db_schemas()
    end

    return db:insert("command_usages", {
        source = source,
        command = cmd,
      })
  end)
end

local function get_last_command(source)
  return sql.with_open(db_path, function(db)
    if not db:exists("command_usages") then
      setup_db_schemas()
      return nil
    end

    local last_command = db:eval([[
      select command from command_usages
      where source = ?
      order by id desc
      limit 1;
      ]], source)[1]["command"]

    return last_command
  end)
end

return {
  insert_command = insert_command,
  get_last_command = get_last_command,
}
