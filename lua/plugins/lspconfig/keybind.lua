-- 定义一个模块 M
local M = {}

-- 定义一个函数 mapLSP，用于绑定 LSP 相关的快捷键
M.mapLSP = function(buffer_id)
    -- 为指定的缓冲区设置键盘映射
    vim.api.nvim_buf_set_keymap(buffer_id, "n", "<leader>f", "", {
        noremap = true, -- 禁用递归映射
        silent = true, -- 执行时不显示命令行
        callback = function() -- 当按下 <leader>f 时执行的回调函数
            local conform = require("conform") -- 引入 conform 插件
            conform.format({ -- 调用 conform 的格式化方法
                bufnr = buffer_id, -- 指定要格式化的缓冲区
                async = false, -- 是否异步执行格式化
                lsp_fallback = true, -- 如果格式化失败，是否回退到 LSP 进行格式化
            })
        end,
    })
end

return M -- 导出模块 M
