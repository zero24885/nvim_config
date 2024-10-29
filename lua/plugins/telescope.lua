local status, telescope = pcall(require, "telescope")
if not status then
    vim.notify("not found telescope") -- 如果找不到 telescope 插件，发送通知
    return
end

telescope.setup({
    defaults = {
        -- 打开弹出窗口后进入的初始模式，默认是插入模式，也可以设置为正常模式
        initial_mode = "insert",
        -- 窗口中的快捷键映射
        mappings = {
            i = {
                -- 上下移动选项
                ["<C-j>"] = "move_selection_next", -- 移动到下一个选项
                ["<C-k>"] = "move_selection_previous", -- 移动到上一个选项
                ["<Down>"] = "move_selection_next", -- 向下箭头键的功能
                ["<Up>"] = "move_selection_previous", -- 向上箭头键的功能
                -- 历史记录
                ["<C-n>"] = "cycle_history_next", -- 切换到下一个历史记录
                ["<C-p>"] = "cycle_history_prev", -- 切换到上一个历史记录
                -- 关闭窗口
                ["<C-c>"] = "close", -- 关闭弹出窗口
                -- 预览窗口滚动
                ["<C-u>"] = "preview_scrolling_up", -- 向上滚动预览窗口
                ["<C-d>"] = "preview_scrolling_down", -- 向下滚动预览窗口
            },
        },
        -- 忽略的文件模式（例如：node_modules、dist、__pycache__）
        file_ignore_patterns = { "node_modules", "dist", "__pycache__" },
    },
    pickers = {
        -- 内置选择器的配置
        find_files = {
            -- 查找文件时的主题，支持参数有：dropdown、cursor、ivy
            -- theme = "dropdown", -- 可选的主题（已注释）
            hidden = false, -- 是否显示隐藏文件
        },
    },
    extensions = {
        undo = {
            side_by_side = true, -- 是否并排显示撤销历史
            layout_strategy = "vertical", -- 布局策略为垂直布局
            layout_config = {
                preview_height = 0.8, -- 预览窗口的高度占据 80%
            },
        },
        fzf = {
            fuzzy = true, -- 启用模糊匹配，设置为 false 将只进行精确匹配
            override_generic_sorter = true, -- 覆盖通用排序器
            override_file_sorter = true, -- 覆盖文件排序器
            case_mode = "smart_case", -- 大小写模式，支持 "smart_case"、"ignore_case" 或 "respect_case"
            -- 默认大小写模式是 "smart_case"
        },
        aerial = {
            -- 以 <root>.<parent>.<symbol> 的形式显示符号
            show_nesting = {
                ["_"] = false, -- 默认情况下不显示嵌套
                json = true, -- 针对特定文件类型设置选项
                yaml = true, -- 针对 YAML 文件类型显示嵌套
            },
        },
    },
})

-- Telescope 扩展
telescope.load_extension("undo") -- 加载撤销扩展
telescope.load_extension("live_grep_args") -- 加载实时 grep 扩展
local status_new, _ = pcall(require, "aerial")
if status_new then
    telescope.load_extension("aerial") -- 加载 aerial 扩展
end

local tool = require("tool")
local map = tool.map
-- 查找文件
map("n", "<C-p>", "<CMD>Telescope find_files<CR>") -- 使用 <C-p> 快捷键查找文件
-- 全局搜索
map("n", "<C-f>", "<CMD>Telescope live_grep<CR>") -- 使用 <C-f> 快捷键进行全局搜索
-- 工作区诊断
map("n", "<leader>wd", "<CMD>Telescope diagnostics<CR>") -- 使用 <leader>wd 查看工作区诊断
-- 撤销
map("n", "<leader>u", "<CMD>Telescope undo<cr>") -- 使用 <leader>u 查看撤销历史

