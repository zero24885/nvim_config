-- 尝试安全加载 bufferline 插件
local status, bufferline = pcall(require, "bufferline")
if not status then
    -- 如果加载失败，使用 notify 提示插件未找到
    vim.notify("not found bufferline")
    return
end

-- 引入自定义工具模块
local tool = require("tool")

-- bufferline 插件配置
-- 参考文档：https://github.com/akinsho/bufferline.nvim#configuration
---@diagnostic disable-next-line: missing-fields
bufferline.setup({
    ---@diagnostic disable-next-line: missing-fields
    options = {
        -- 使用 moll/vim-bbye 插件的 :Bdelete 命令来关闭标签
        close_command = "Bdelete! %d",
        -- 右键点击关闭标签
        right_mouse_command = "Bdelete! %d",
        -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
            },
        },

        -- 使用内置 LSP 显示诊断信息，后续会进行配置
        diagnostics = "nvim_lsp",
        -- 可选，显示 LSP 错误图标
        ---@diagnostic disable-next-line: unused-local
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            -- 遍历诊断字典，构建状态字符串
            for e, n in pairs(diagnostics_dict) do
                -- local sym = e == "error" and "" or (e == "warning" and "" or "")
                local sym = e == "error" and "✖" or (e == "warning" and "⚠" or "ℹ")
                s = s .. n .. sym -- 将数量和符号拼接
            end
            return s -- 返回最终的状态字符串
        end,
    },
})

-- vim.notify("标签栏加载完成")

-- 自定义键位映射
tool.map("n", "bn", "<CMD>BufferLineCycleNext<cr>") -- 切换到下一个标签
tool.map("n", "bp", "<CMD>BufferLineCyclePrev<cr>") -- 切换到上一个标签
tool.map("n", "bd", "<CMD>Bdelete!<cr>") -- 关闭当前标签

tool.map("n", "<leader>bl", "<CMD>BufferLineCloseRight<cr>") -- 关闭右侧所有标签
tool.map("n", "<leader>bh", "<CMD>BufferLineCloseLeft<cr>") -- 关闭左侧所有标签
tool.map("n", "<leader>bn", "<CMD>BufferLineMoveNext<cr>") -- 移动当前标签到右侧
tool.map("n", "<leader>bp", "<CMD>BufferLineMovePrev<cr>") -- 移动当前标签到左侧

