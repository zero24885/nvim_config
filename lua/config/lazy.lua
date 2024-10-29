local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- 如果 lazy.nvim 没有安装，尝试从 GitHub 克隆
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

-- 将 lazy.nvim 加入 runtime path
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- 使用 lazy.nvim 来管理插件
require("lazy").setup({
    -- 自我管理的插件
    "folke/lazy.nvim",
     -- 通知管理
    "rcarriga/nvim-notify",
    -- 主题
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },

    -- 文件浏览器
    {
        "nvim-tree/nvim-tree.lua",
        event = "UIEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- 文件图标支持
        },
    },

    -- 缓冲区行插件
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- 文件图标支持
            "moll/vim-bbye", -- 关闭缓冲区的功能
        },
        event = "UIEnter",
    },

    -- 状态行插件
    {
        "nvim-lualine/lualine.nvim",
        event = "UIEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- 文件图标支持
            "f-person/git-blame.nvim", -- Git blame 支持
        },
    },

    -- 窗口管理
    {
        "anuvyklack/windows.nvim",
        event = "VeryLazy",
        enabled = true,
        dependencies = "anuvyklack/middleclass", -- 依赖
    },

    -- LSP 进度指示器
    {
        "j-hui/fidget.nvim",
        branch = "legacy",
        event = "VeryLazy",
    },

    -- LSP UI
    {
        "jinzhongjia/LspUI.nvim",
        branch = "main",
        event = "VeryLazy",
    },

    -- 符号行
    {
        "stevearc/aerial.nvim",
        event = "VeryLazy",
        enabled = false,
    },

    -- 浮动终端
    {
        "voldikss/vim-floaterm",
        event = "VeryLazy",
    },

    -- Git 签名支持
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
    },
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
    },

    -- Treesitter 插件
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })() -- 更新解析器
        end,
    },

    -- 缩进指示插件
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
    },

    -- Mason 插件
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        dependencies = {
            "neovim/nvim-lspconfig", -- LSP 配置
            "creativenull/efmls-configs-nvim", -- LSP 配置集合
            "williamboman/mason-lspconfig.nvim", -- Mason 与 LSP 的集成
            "b0o/schemastore.nvim", -- JSON schema 存储
        },
    },

    -- LSP 配置
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            "creativenull/efmls-configs-nvim", -- LSP 配置集合
            "b0o/schemastore.nvim", -- JSON schema 存储
        },
    },

    -- 自动补全
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP 源
            "hrsh7th/cmp-buffer", -- 缓冲区源
            "FelipeLema/cmp-async-path", -- 异步路径补全
            "lukas-reineke/cmp-rg", -- rg 搜索补全
            "hrsh7th/cmp-cmdline", -- 命令行补全
            {
                "garymjr/nvim-snippets", -- 代码片段支持
                opts = {
                    friendly_snippets = true, -- 启用友好代码片段
                },
            },
            "onsails/lspkind-nvim", -- LSP 图标
            "windwp/nvim-autopairs", -- 自动配对括号
            "rafamadriz/friendly-snippets", -- 友好的代码片段
        },
        event = "VeryLazy",
    },

    -- 文件搜索与导航
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", -- 依赖库
            "debugloop/telescope-undo.nvim", -- 撤销历史支持
            {
                "nvim-telescope/telescope-fzf-native.nvim", -- fzf 支持
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build", -- 构建指令
            },
            "nvim-telescope/telescope-live-grep-args.nvim", -- 实时 grep
        },
        event = "VeryLazy",
    },

    -- 高亮参数
    {
        "m-demare/hlargs.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- 依赖 Treesitter
        },
        event = "VeryLazy",
    },

    -- format
    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
        enabled = true,
    },
    -- indent
    {
        "nmac427/guess-indent.nvim",
        event = "VeryLazy",
    },
    -- board
    {
        "goolord/alpha-nvim",
        event = "VIMEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    -- terminal
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
    },
    {
        "willothy/flatten.nvim",
        event = "VeryLazy",
        config = true,
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        opts = {},
    },

    -- 异步任务执行
    {
        "skywind3000/asynctasks.vim",
        dependencies = {
            "skywind3000/asyncrun.vim",  -- 依赖于 asyncrun.vim
        },
        event = "VeryLazy",  -- 懒惰加载
        config = function()
            vim.g.asyncrun_open = 6  -- 设置异步运行窗口的打开方式
        end,
    },
    -- 高亮 当前光标下的单词
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            require("illuminate").configure({
                filetypes_denylist = {
                    "dirbuf",
                    "dirvish",
                    "fugitive",
                    "NvimTree",
                    "Outline",
                    "LspUI-rename",
                    "LspUI-diagnostic",
                    "LspUI-code_action",
                    "LspUI-definition",
                    "LspUI-type_definition",
                    "LspUI-declaration",
                    "LspUI-reference",
                    "LspUI-implementation",
                    "mason",
                    "floaterm",
                    "lazy",
                    "alpha",
                },
            })
        end,
    },
    -- 显示大纲
    {
        "hedyhli/outline.nvim", -- 插件名称
        -- dev = true,            -- 开发模式
        
        lazy = true,           -- 延迟加载插件
    },
    -- 专注
    {
    --    "folke/zen-mode.nvim",
    --    event = "VeryLazy",
    --    opts = {},
    },
 
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        }
    },
    -- 按键提示
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        dependencies = {
            "echasnovski/mini.icons",
            lazy = true, -- 或根据你的需求设置为 false
        },
    },

    -- 基本配置
    checker = {
        enabled = true,
    },
    install = {
        colorscheme = { "arctic" },
    },
}
)
