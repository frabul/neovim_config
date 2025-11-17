return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local util = require("lspconfig.util")
      -- If you installed via Mason:
      local omnisharp_run = vim.fn.stdpath("data") .. "/mason/packages/omnisharp-mono/run"

      opts.servers = opts.servers or {}
      opts.servers.omnisharp = {
        -- Use the Mono/NET Framework server:
        cmd = { omnisharp_run, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },

        -- Optional quality-of-life flags:
        enable_import_completion = true,
        organize_imports_on_format = true,
        enable_roslyn_analyzers = true,

        -- Robust root detection for legacy solutions:
        root_dir = function(fname)
          return util.root_pattern("*.sln")(fname)
            or util.root_pattern("*.csproj")(fname)
            or util.root_pattern(".git")(fname)
            or vim.loop.cwd()
        end,
      }
    end,
  },
}
