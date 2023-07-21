return {
    -- Configure AstroNvim updates
    updater = {
        remote = "origin", -- remote to use
        channel = "stable", -- "stable" or "nightly"
        version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
        branch = "nightly", -- branch name (NIGHTLY ONLY)
        commit = nil, -- commit hash (NIGHTLY ONLY)
        pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
        skip_prompts = false, -- skip prompts about breaking changes
        show_changelog = true, -- show the changelog after performing an update
        auto_quit = false, -- automatically quit the current session after a successful update
        remotes = { -- easily add new remotes to track
            --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
            --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
            --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
        }
    },
    -- Set colorscheme to use
    -- colorscheme = "astrodark",
    colorscheme = "monokai_pro",
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {virtual_text = true, underline = true},
    options = function(local_vim)
        local_vim.g['sneak#label'] = 1
        local_vim.g['copilot_no_tab_map'] = "v:true"
        local_vim.opt.relativenumber = false
        local_vim.opt.scrolloff = 10
        return local_vim
    end,
    lsp = {
        -- customize lsp formatting options
        formatting = {
            -- control auto formatting on save
            format_on_save = {
                enabled = true, -- enable or disable format on save globally
                allow_filetypes = { -- enable format on save for specified filetypes only
                    -- "scss",
                    -- "php",
                    -- "css",
                    -- "js",
                    -- "vue"
                },
                ignore_filetypes = { -- disable format on save for specified filetypes
                    -- "python",
                    "lua"
                }
            },
            disabled = { -- disable formatting capabilities for the listed language servers
                -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
                -- "lua_ls",
            },
            timeout_ms = 1000 -- default format timeout
            -- filter = function(client) -- fully override the default formatting function
            --   return true
            -- end
        },
        -- enable servers that you already have installed without mason
        servers = {
            -- "pyright"
            "intelephense" --
        },
        config = {
            intelephense = function()
                return {
                    cmd = {"intelephense", "--stdio"},
                    filetypes = {"php"},
                    settings = {
                        intelephense = {
                            files = {maxSize = 1000000},
                            environment = {
                                includePaths = {
                                    "/home/serii/Sites/wordpress",
                                    "/home/serii/Sites/advanced-custom-fields-pro",
                                    "/home/serii/Sites/woocommerce"
                                }
                            }
                        }
                    }
                }
            end
        }
    },
    -- Configure require("lazy").setup() options
    lazy = {
        defaults = {lazy = true},
        performance = {
            rtp = {
                -- customize default disabled vim plugins
                disabled_plugins = {
                    "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin",
                    "tarPlugin"
                }
            }
        }
    },
    plugins = {
        {"tpope/vim-fugitive", lazy = false}, {"mattn/emmet-vim", lazy = false},
        {"justinmk/vim-sneak", lazy = false},
        {"github/copilot.vim", lazy = false},
        {"mg979/vim-visual-multi", lazy = false}, {"tanvirtin/monokai.nvim"}, {
            "L3MON4D3/LuaSnip",
            config = function(plugin, opts)
                require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
                require("luasnip.loaders.from_vscode").lazy_load {
                    paths = {"./lua/user/snippets"}
                } -- load snippets paths
            end,
            lazy = false
        }, {
            "Pocco81/auto-save.nvim",
            config = function()
                require("auto-save").setup {
                    enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
                    execution_message = {
                        message = function() -- message to print on save
                            return ("AutoSave: saved at " ..
                                       vim.fn.strftime("%H:%M:%S"))
                        end,
                        dim = 0.18, -- dim the color of `message`
                        cleaning_interval = 1250 -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
                    },
                    trigger_events = {"BufLeave", "FocusLost"}, -- vim events that trigger auto-save. See :h events
                    -- function that determines whether to save the current buffer or not
                    -- return true: if buffer is ok to be saved
                    -- return false: if it's not ok to be saved
                    condition = function(buf)
                        local fn = vim.fn
                        local utils = require("auto-save.utils.data")

                        if fn.getbufvar(buf, "&modifiable") == 1 and
                            utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                            return true -- met condition(s), can save
                        end
                        return false -- can't save
                    end,
                    write_all_buffers = false, -- write all buffers when the current one meets `condition`
                    debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
                    callbacks = { -- functions to be executed at different intervals
                        enabling = nil, -- ran when enabling auto-save
                        disabling = nil, -- ran when disabling auto-save
                        before_asserting_save = nil, -- ran before checking `condition`
                        before_saving = nil, -- ran before doing the actual save
                        after_saving = nil -- ran after doing the actual save
                    }
                }
            end,
            lazy = false
        }
    },
    cmp = {
        source_priority = {
            nvim_lsp = 1000,
            luasnip = 750,
            buffer = 500,
            path = 250
        }
    },
    -- This function is run last and is a good place to configuring
    -- augroups/autocommands and custom filetypes also this just pure lua so
    -- anything that doesn't fit in the normal config locations above can go here
    --
    polish = function()
        -- Set up custom filetypes
        -- vim.filetype.add {
        --   extension = {
        --     foo = "fooscript",
        --   },
        --   filename = {
        --     ["Foofile"] = "fooscript",
        --   },
        --   pattern = {
        --     ["~/%.config/foo/.*"] = "fooscript",
        --   },
        -- }
    end
}
