local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local n_mappings = {
    ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    ["b"] = {
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Buffers",
    },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["w"] = { "<cmd>w!<cr>", "Save" },
    ["q"] = { "<cmd>q!<cr>", "Quit" },
    ["c"] = { "<cmd>Bdelete!<cr>", "Close Buffer" },
    ["h"] = { "<cmd>nohlsearch<cr>", "No Highlight" },
    d = {
        name = 'Debugger',
        b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        t = { "<cmd>lua require'dapui'.toggle()<cr>",          "Toggle UI" },
        c = { "<cmd>lua require'dap'.continue()<cr>",          "Continue" },
        i = { "<cmd>lua require'dap'.step_into()<cr>",         "Step Into" },
        o = { "<cmd>lua require'dap'.step_out()<cr>",          "Step Out" },
        O = { "<cmd>lua require'dap'.step_over()<cr>",         "Step Over" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>",       "Toggle Repl" },
        s = { "<cmd>lua require'dap'.continue()<cr>",          "Start" },
        S = { "<cmd>lua require'dap'.close()<cr>",             "Stop" }
    },
    p = {
        name = "Plugins (lazyvim)",
        b = { "<cmd>Lazy build<cr>", "Build Plugin" },
        c = { "<cmd>Lazy check<cr>", "Check for Updates" },
        l = { "<cmd>Lazy clean<cr>", "Clean Plugins" },
        r = { "<cmd>Lazy clear<cr>", "Clear Finished Tasks" },
        d = { "<cmd>Lazy debug<cr>", "Debug Info" },
        h = { "<cmd>Lazy health<cr>", "Health Check" },
        m = { "<cmd>Lazy home<cr>", "Plugin List" },
        i = { "<cmd>Lazy install<cr>", "Install Plugins" },
        o = { "<cmd>Lazy load<cr>", "Load Plugin" },
        g = { "<cmd>Lazy log<cr>", "Plugin Log" },
        p = { "<cmd>Lazy profile<cr>", "Profiling" },
        e = { "<cmd>Lazy reload<cr>", "Reload Plugin" },
        s = { "<cmd>Lazy restore<cr>", "Restore Plugin" },
        y = { "<cmd>Lazy sync<cr>", "Sync Plugins" },
        u = { "<cmd>Lazy update<cr>", "Update Plugins" },
        ["%"] = { "<cmd>source ~/.config/nvim/lua/futurisold/plugins.lua <cr>", "" }
    },
    g = {
        name = "Git",
        g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Diff",
        },
    },

    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = {
            "<cmd>Telescope diagnostics bufnr=0<cr>",
            "Document Diagnostics",
        },
        w = {
            "<cmd>Telescope diagnostics<cr>",
            "Workspace Diagnostics",
        },
        f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
        j = {
            "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
            "Next Diagnostic",
        },
        k = {
            "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic",
        },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
    },

    o = {
        name = "Remote (sshfs)",
        c = { "<cmd>RemoteSSHFSConnect<cr>", "Connect" },
        d = { "<cmd>RemoteSSHFSDisconnect<cr>", "Disconnect" },
    },

    s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        h = { "<cmd>Telescope help_tags<cr>", "Help Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        c = { "<cmd>Telescope commands<cr>", "Commands" },
        f = { "<cmd>Telescope find_files<cr>", "Find files" },
        g = { "<cmd>Telescope live_grep_args<cr>", "Find text with rg" },
    },

    t = {
        name = "Terminal",
        n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
        u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
        t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
        p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    },

    r = {
        name = "Query/Replace",
        s = { "<cmd>SearchReplaceSingleBufferSelections<cr>", "[s]election list"},
        W = { "<cmd>SearchReplaceSingleBufferCWORD<cr>", "[W]ORD" },
        w = { "<cmd>SearchReplaceSingleBufferCWord<cr>", "[w]ord" },
        o = { "<cmd>SearchReplaceSingleBufferOpen<cr>",  "[o]pen" },
        e = { "<cmd>SearchReplaceSingleBufferCExpr<cr>", "[e]xpr" },
        f = { "<cmd>SearchReplaceSingleBufferCFile<cr>", "[f]ile" },
    },

    x = {
        name = "LaTeX",
        a = { "<cmd>VimtexCompile<cr>", "Start compiler in continuous mode" },
        s = { "<cmd>VimtexStop<cr>", "Stop compiler" },
        c = { "<cmd>VimtexCompileSS<cr>", "Compile" },
        e = { "<cmd>VimtexErrors<cr>", "Errors" },
        r = { "<cmd>VimtexReload<cr>", "Reload plugin" }
    }
}

local v_mappings = {
    r = {
        name = "Query/Replace",
        w = { "<cmd>SearchReplaceWithinVisualSelection<cr>",       "Charwise" },
        c = { "<cmd>SearchReplaceWithinVisualSelectionCWord<cr>",  "Blockwise/Linewise" },
    }
}

local n_opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local v_opts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

which_key.setup(setup)
which_key.register(n_mappings, n_opts)
which_key.register(v_mappings, v_opts)

