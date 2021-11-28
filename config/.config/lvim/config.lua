--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "gruvbox-material"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.term_mode["<Esc>"] = "<C-\\><C-n>"

-- (N)Vim options
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.dap.active = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
   {"sainnhe/gruvbox-material"},
   {"shatur/neovim-cmake"},
   {"theHamsta/nvim-dap-virtual-text",
    config = function()
        require("nvim-dap-virtual-text").setup()
        end,
    },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

local lsp_installer_servers = require'nvim-lsp-installer.servers'

local ok, clangd_server = lsp_installer_servers.get_server("clangd")
if ok then
    if not clangd_server:is_installed() then
        clangd_server:install()
    end
end


local dap = require('dap')
dap.adapters.codelldb = function(on_adapter)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  -- CHANGE THIS!
  local home = os.getenv("HOME");
  local cmd = home .. '/.local/share/nvim/dapinstall/codelldb/extension/adapter/codelldb'
  local handle, pid_or_err
  local opts = {
    stdio = {nil, stdout, stderr},
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)
  assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      local port = chunk:match('Listening on port (%d+)')
      if port then
        vim.schedule(function()
          on_adapter({
            type = 'server',
            host = '127.0.0.1',
            port = port
          })
        end)
      else
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end
  end)
  stderr:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
end

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  }
}
dap.configurations.c = dap.configurations.cpp

-- CMake Whickkey Menu
lvim.builtin.which_key.mappings["C"] = {
    name = "CMake",
    s = { "<cmd>:Telescope cmake select_target<CR>", "Select target"},
    b = { "<cmd>:CMake build<CR>", "Build"},
    a = { "<cmd>:CMake build_all<CR>", "Build all"},
    c = { "<cmd>:CMake configure<CR>", "Configure project"},
    r = { "<cmd>:CMake run<CR>", "Run selected target"},
    d = { "<cmd>:CMake debug<CR>", "Debug selected target"},
    l = { "<cmd>:CMake clean<CR>", "Clean target"},
}

require('cmake').setup({
  dap_configuration = {
    type = 'codelldb',
    request = 'launch',
    stopOnEntry = false,
    runInTerminal = false,
}})

-- Debug Whichkey Menu
-- lvim.builtin.which_key.mappings["d"] = {
--   name = "Debug",
--   b = { "<cmd>:lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
lvim.builtin.which_key.mappings["dz"] = { "<cmd>:lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Conditional Breakpoint" }
lvim.builtin.which_key.mappings["dy"] = { "<cmd>:lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "Log Breakpoint" }
--   r = { "<cmd>:lua require'dap'.continue()<CR>", "Run/Continue (<F5>)" },
--   u = { "<cmd>:lua require'dap'.step_over()<CR>", "Step over (<F10>)" },
--   i = { "<cmd>:lua require'dap'.step_into()<CR>", "Step into (<F11>)" },
--   o = { "<cmd>:lua require'dap'.step_out()<CR>", "Step out (<F12>)" },
--   p = { "<cmd>:lua require'dap'.repl_open()<CR>", "Open Repl" },
--   a = { "<cmd>:lua require'dap'.run_last()<CR>", "Run last" },
-- }

-- Keybindings for nvim-dap
vim.cmd(
    [[
     nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
     nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
     nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
     nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
    ]]
)
