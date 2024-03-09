# git-linker

Adds a `GitLink` command to generate a web link to the current file in the
repository.

`git-linker.nvim` generates links based on the current git origin URL. However,
it is limited to repositories that follow the GitHub URL format.

To include support for another git web provider, please provide the following
information in a new issue:

- The format of a web link to the file on a specific commit (e.g. to commit
  4716818d, not to `main`)
- The format of a web link to a specific line
- The format of a web link to a line range
- The git remote URL format for both HTTP and SSH remotes

# Installation

Installation with [lazy.nvim](https://github.com/folke/lazy.nvim) is supported:

```lua
return {
 'jgoguen/git-linker.nvim',
  opts = {
    print_url = false,
  }
}
```

Your Neovim configuration should, after this plugin is loaded, call
`:helptags ALL`. This will make help available with `:help git-linker.nvim` or
`:help GitLink`.

# Configuration

git-linker.nvim comes with the following defaults:

```lua
{
  copy_to_clipboard = true,
  fallback_branch = nil,
  fallback_url_format = nil,
  print_url = true,
}
```

Any of these may be overridden by passing them to `setup()`.

- `copy_to_clipboard`: If this is `true`, the generated URL will be copied to
  the system clipboard (via the `+` register).
- `fallback_branch`: If this is not `nil`, this branch will be used to resolve
  the commit hash if the current branch has not been pushed to origin. This is
  useful if your main upstream branch is something other than `main` or `master`,
  such as `dev`.
- `fallback_url_format`: If this is not `nil`, and a URL format isn't found from
  the git remote URL, use this as the URL format string. It may be an index into
  `config.formats`, or a format string. If a format string is given, there must
  be four parameters:
  - The host and base path (e.g. `github.com/user/repo`)
  - The commit hash
  - The file path relative to the repo root (e.g. `doc/README.md`)
  - The line number(s) (e.g. `L10` or `L10-L15`)
- `print_url`: If this is `true`, the generated URL will be printed. This will
  cause a vim message to be displayed
