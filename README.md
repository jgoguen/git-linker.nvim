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
  url = 'https://codeberg.org/jgoguen/git-linker.nvim',
}
```

# Configuration

No configuration options are available at this time.
