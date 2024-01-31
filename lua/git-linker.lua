local config = require("git-linker.config")
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

	---@type string|nil
	local url_format = nil
	if string.find(url, "github.com") then
		url_format = util.formats.github
	elseif string.find(url, "codeberg.org") then
		url_format = util.formats.codeberg
	elseif config.options.fallback_url_format ~= nil then
		local fmt = util.formats[config.options.fallback_url_format]
		if fmt ~= nil then
			url_format = fmt
		else
			url_format = config.options.fallback_url_format
		end
	end
	assert(url_format, "No URL format found")

	url = string.format(url_format, url, commit, relative_file, line_numbers)

	if config.options.copy_to_clipboard then
		vim.fn.setreg("+", url)
	end

	if config.options.print_url then
		print(url)
	end
end

function M.setup(opts)
	config.setup(opts)
end

return M
