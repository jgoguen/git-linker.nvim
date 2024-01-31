local M = {}

---Get the commit hash of the current branch, or upstream main/master if the
--current branch isn't pushed to origin.
---@return string|nil
function M.get_upstream_commit()
	-- Start by getting the current branch name
	local current_branch = io.popen("git rev-parse --abbrev-ref HEAD"):read()

	-- Get the commit hash from git metadata
	local root_dir = io.popen("git rev-parse --show-toplevel"):read()
	local f = io.open(root_dir .. "/.git/refs/remotes/origin/" .. current_branch, "r")
	if not f then
		-- No? OK, check for main.
		f = io.open(root_dir .. "/.git/refs/remotes/origin/main", "r")
		if not f then
			-- Still no? Maybe master.
			f = io.open(root_dir .. "/.git/refs/remotes/origin/master", "r")
			if not f then
				-- Really? Too bad.
				return nil
			end
		end
	end

	local commit = f:read()
	f:close()
	return commit
end

return M
