---@diagnostic disable-next-line: missing-fields
local notify = require("notify")
notify.setup({top_down = false, render = "compact"})
notify.notify("that bat.")
