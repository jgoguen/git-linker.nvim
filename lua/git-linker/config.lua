local M = {}

---@class GitLinkerOptions
---@field fallback_branch string|nil
---@field fallback_url_format string|nil
local defaults = {
	copy_to_clipboard = true,
	fallback_branch = nil,
	fallback_url_format = nil,
	print_url = true,
}

---@type GitLinkerOptions
M.options = {}

function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})
end

M.setup()

return M
