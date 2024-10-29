local ok, wk = pcall(require, "which-key")
if not ok then
    vim.notify("Failed to load which-key.nvim", vim.log.levels.ERROR)
    return
end

wk.setup({
})

-- 将插件映射到which-key 方便查看
wk.add({
    {
        {"<leader>t" , group = "终端相关"},
        {"<leader>tb", ":lua _bottom_terminal_toggle()<CR>", desc = "在下方创建终端", mode = "n",},
        {"<leader>tf", ":lua _float_terminal_toggle()<CR>", desc = "创建一个悬浮终端", mode = "n",},
    },

    {
        {"<leader>g", group = "Lsp相关"},
        {"<leader>gd", "<CMD>LspUI definition<CR>", desc = "跳转到定义", mode = "n", },
        {"<leader>gD", "<CMD>LspUI declaration<CR>", desc = "跳转到声明", mode = "n",},
        {"<leader>gi", "<CMD>LspUI implementation<CR>", desc = "跳转到实现", mode = "n",},
        {"<leader>gr", "<CMD>LspUI reference<CR>", desc = "跳转到引用", mode = "n",},
        {"<leader>gy", "<CMD>LspUI type_definition<CR>", desc = "跳转到类型定义", mode = "n",},
        {"<leader>gj", "<CMD>LspUI diagnostic next<CR>", desc = "跳转到上一个诊断", mode = "n",},
        {"<leader>gk", "<CMD>LspUI diagnostic prev<CR>", desc = "跳转到下一个诊断", mode = "n",},
        
    },

    {
        {"<leader>b", group = "标签栏相关",},
        {"<leader>bn",  "<CMD>BufferLineCycleNext<cr>", desc = "切换到下一标签", mode = "n", },
        {"<leader>bp",  "<CMD>BufferLineCyclePrev<cr>", desc = "切换到上一个标签", mode = "n", },
        {"<leader>bd",  "<CMD>Bdelete!<cr>", desc = "关闭当前标签", mode = "n", },
        {"<leader>bl",  "<CMD>BufferLineCloseRight<cr>", desc = "关闭右侧标签", mode = "n", },
        {"<leader>bh",  "<CMD>BufferLineCloseLeft<cr>", desc = "关闭左侧标签", mode = "n", },
        {"<leader>bbn",  "<CMD>BufferLineMoveNext<cr>", desc = "移动当前标签到右侧", mode = "n", },
        {"<leader>bbp",  "<CMD>BufferLineMovePrev<cr>", desc = "移动当前标签到左侧", mode = "n", },
    },

    {
        {"<leader>", group = "",},
        {"<leader>", "", desc = "", mode = "n", },

    },
})
