-- 尝试安全加载 nvim-tree 插件
local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    -- 如果加载失败，使用 notify 提示插件未找到
    vim.notify("not found nvim-tree")
    return
end

-- 引入自定义工具模块
local tool = require("tool")

-- 配置 nvim-tree 插件
nvim_tree.setup({
    -- 禁用 netrw 插件，避免冲突
    disable_netrw = true,
    
    -- 同步根目录与当前工作目录
    sync_root_with_cwd = true,

    -- 过滤器配置
    filters = {
        -- 显示 dotfiles（以 . 开头的文件）
        dotfiles = true,
        -- 自定义过滤的目录
        custom = { "node_modules" },
    },

    -- 文件打开行为配置
    actions = {
        open_file = {
            -- 首次打开时调整窗口大小
            resize_window = true,
            -- 打开文件后关闭 nvim-tree
            quit_on_open = true,
        },
    },

    -- 键位映射覆盖
    on_attach = function(buffer_id)
        -- 引入 nvim-tree 的 API
        local api = require("nvim-tree.api")

        -- 帮助函数，用于设置键位映射的选项
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = buffer_id, noremap = true, silent = true, nowait = true }
        end
        
        -- 使用默认的映射
        api.config.mappings.default_on_attach(buffer_id)

        -- 自定义键位映射
        vim.keymap.set("n", "sv", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "sh", api.node.open.horizontal, opts("Open: Horizontal Split"))
    end,

    -- Git 配置
    git = {
        -- 设置 Git 操作的超时时间
        timeout = 5000,
    },
})

-- vim.notify("文件树加载成功")
-- 自定义映射：使用 <leader>e 切换 nvim-tree
tool.map("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")
