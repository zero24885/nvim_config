-- 尝试加载 lualine 插件
local status, lualine = pcall(require, "lualine")
if not status then
    vim.notify("not found lualine") -- 如果未找到插件，显示通知
    return
end

vim.g.gitblame_display_virtual_text = 0 -- 关闭 Git Blame 的虚拟文本显示

-- local LspUI = require("LspUI") -- 加载 LspUI，用于获取 LSP 签名
local git_blame = require("gitblame") -- 加载 git-blame，用于获取当前文件的 Git 提交信息

local is_insert = false -- 用于跟踪是否处于插入模式
local is_blame = false -- 用于跟踪是否显示 Git Blame 信息

-- 配置 lualine
lualine.setup({
    sections = {
        lualine_x = {
            {
                require("lazy.status").updates, -- 显示 lazy.nvim 的更新状态
                cond = require("lazy.status").has_updates, -- 仅在有更新时显示
                color = { fg = "#ff9e64" }, -- 设置字体颜色
            },
            "encoding", -- 显示当前文件编码
            "fileformat", -- 显示当前文件格式（如 Unix、DOS 等）
            "filetype", -- 显示当前文件类型
        },
        lualine_c = {
            {
                function()
                    -- 如果处于插入模式，显示 LSP 签名
                    -- if is_insert then
                    --    local signature = LspUI.api.signature() -- 获取当前 LSP 签名信息
                    --    if not signature then
                    --        return "" -- 如果没有签名信息，返回空字符串
                    --    end
                    --    if not signature.hint then
                    --        return signature.label -- 返回签名标签
                    --    end

                    --   return signature.parameters[signature.hint].label -- 返回当前参数的标签
                    -- elseif is_blame then
                        return git_blame.get_current_blame_text() -- 返回当前 Git Blame 信息
                    -- end
                end,
                cond = function()
                    -- 获取当前模式信息
                    local mode_info = vim.api.nvim_get_mode()
                    local mode = mode_info["mode"]
                    -- 检查是否处于插入模式
                    is_insert = mode:find("i") ~= nil or mode:find("ic") ~= nil

                    -- 获取当前 Git Blame 信息
                    local text = git_blame.get_current_blame_text()
                    if text then
                        is_blame = text ~= "" -- 如果有 Git Blame 信息，则设置为 true
                    else
                        is_blame = false -- 否则设置为 false
                    end

                    return is_insert or is_blame -- 如果处于插入模式或有 Git Blame 信息，则返回 true
                end,
            },
        },
    },
})

--vim.notify("状态栏加载完成")
