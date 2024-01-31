local util = require("git-linker.util")
local M = {}

function M.getLink(start_line, end_line)
	-- Get the origin. This will be a HTTPS or SSH URL
	local origin = io.popen("git remote get-url origin"):read()

	-- Git root directory
	local root_dir = io.popen("git rev-parse --show-toplevel"):read()

	-- Current commit
	local commit = util.get_upstream_commit()
	assert(commit, "No origin commit found")

	-- Relative path to file
	local current_file = vim.fn.expand("%:p")
	local relative_file = vim.fn.fnamemodify(current_file, ":gs#" .. root_dir .. "/##")

	-- Get the base URL for the file
	local url = origin:gsub(".git$", "")
	if string.find(url, "git@") then
		url = url:gsub("^git@", ""):gsub(":", "/")
	end

	local line_numbers = ""
	if start_line then
		line_numbers = string.format("L%d", start_line)
		if start_line ~= end_line then
			line_numbers = line_numbers .. string.format("-L%d", end_line)
		end
	end

	url = string.format("https://%s/blob/%s/%s#%s", url, commit, relative_file, line_numbers)

	vim.fn.setreg("*", url)
	print(url)
end

return M
