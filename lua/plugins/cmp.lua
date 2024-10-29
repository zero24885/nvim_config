-- 尝试引入 nvim-cmp 插件
local status_cmp, cmp = pcall(require, "cmp")
if not status_cmp then
    vim.notify("not found cmp") -- 如果没有找到插件，通知用户
    return
end

-- 尝试引入 lspkind 插件，用于为补全项添加图标
local status_lspkind, lspkind = pcall(require, "lspkind")
if not status_lspkind then
    vim.notify("not found lspkind") -- 如果没有找到插件，通知用户
    return
end

-- 尝试引入 nvim-autopairs 插件，用于自动配对字符
local status_npairs, npairs = pcall(require, "nvim-autopairs")
if not status_npairs then
    vim.notify("not found nvim-autopairs") -- 如果没有找到插件，通知用户
    return
end

-- 配置 nvim-autopairs
npairs.setup({
    check_ts = true, -- 启用 Treesitter 支持
    ts_config = {
        lua = { "string" }, -- 在 Lua 的字符串节点中不自动配对
        javascript = { "template_string" }, -- 在 JavaScript 的模板字符串中不自动配对
        java = false, -- 在 Java 中不检查 Treesitter
    },
})

-- 引入 nvim-autopairs 和 nvim-cmp 的集成
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- 配置 nvim-cmp
---@diagnostic disable-next-line: missing-fields
cmp.setup({
    preselect = cmp.PreselectMode.None, -- 不自动选择第一个补全项
    window = {
        completion = cmp.config.window.bordered(), -- 使用带边框的窗口样式
        documentation = cmp.config.window.bordered(), -- 文档窗口也使用带边框样式
    },

    -- 指定代码片段引擎
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body) -- 使用 LuaSnip 进行代码片段扩展
        end,
    },

        -- 补全来源配置
    sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- 来自 LSP 的补全
        { name = "snippets" }, -- 代码片段补全
        { name = "copilot" }, -- GitHub Copilot
        { name = "async_path" }, -- 异步路径补全
        { name = "lazydev" }, -- LazyDev 插件
    }, { { name = "buffer" } }), -- 还包括来自缓冲区的补全

    -- 按键映射设置
    mapping = {
        -- 激活补全菜单
        ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- 取消补全
        ["<A-,>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- 上一个补全项
        ["<C-k>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item() -- 如果补全菜单可见，选择上一个项
            else
                fallback() -- 否则调用回退函数
            end
        end,
        -- 下一个补全项
        ["<C-j>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item() -- 如果补全菜单可见，选择下一个项
            else
                fallback()
            end
        end,
        -- 确认补全
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }) -- 确认补全并替换
                else
                    fallback() -- 否则调用回退函数
                end
            end,
            s = cmp.mapping.confirm({ select = true }), -- 在选择模式下确认
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
        -- Tab 键处理
        ["<Tab>"] = cmp.mapping(function(fallback)
            local has_words_before = function()
                if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
                    return false -- 在命令行提示中不处理
                end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
            end

            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end

            if cmp.visible() then
                cmp.select_next_item() -- 如果补全菜单可见，选择下一个项
            elseif vim.snippet.active({ direction = 1 }) then
                feedkey("<cmd>lua vim.snippet.jump(1)<CR>", "") -- 如果代码片段激活，跳转到下一个片段
            elseif has_words_before() then
                cmp.complete() -- 如果光标前有单词，触发补全
            else
                fallback() -- 否则调用回退函数
            end
        end, { "i", "s" }),
        -- Shift+Tab 键处理
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end

            if cmp.visible() then
                cmp.select_prev_item() -- 如果补全菜单可见，选择上一个项
            elseif vim.snippet.active({ direction = -1 }) then
                feedkey("<cmd>lua vim.snippet.jump(-1)<CR>", "") -- 如果代码片段激活，跳转到上一个片段
            end
        end, { "i", "s" }),
        -- 滚动文档
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        -- 自定义代码片段跳转
        ["<C-l>"] = cmp.mapping(function(_)
            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end
            if vim.snippet.active({ direction = 1 }) then
                feedkey("<cmd>lua vim.snippet.jump(1)<CR>", "") -- 跳转到下一个参数
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end
            if vim.snippet.active({ direction = -1 }) then
                feedkey("<cmd>lua vim.snippet.jump(-1)<CR>", "") -- 跳转到上一个参数
            end
        end, { "i", "s" }),
    },

    -- 显示类型图标
    ---@diagnostic disable-next-line: missing-fields
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text", -- 显示符号和文本
            maxwidth = 50, -- 限制最大宽度
            before = function(entry, vim_item)
                --- @cast vim_item vim.CompletedItem
                if entry.source.name == "rg" or entry.source.name == "buffer" then
                    vim_item.dup = nil -- 去重
                end
                vim_item.menu = "[" .. string.upper(entry.source.name) .. "]" -- 显示补全来源
                return vim_item
            end,
            symbol_map = { Copilot = "" }, -- 自定义图标
        }),
    },
})

-- 设置命令行模式的补全
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(), -- 使用预设的按键映射
    sources = cmp.config.sources({
        { name = "async_path" }, -- 异步路径补全
    }, {
        { name = "cmdline" }, -- 命令行补全
    }),
})

-- 设置搜索框的补全
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(), -- 使用预设的按键映射
    sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" }, -- LSP 文档符号补全
    }, {
        { name = "buffer" }, -- 来自缓冲区的补全
    }),
})

-- 处理补全确认后的行为
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
