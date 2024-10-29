-- 尝试加载 alpha 插件
local status, alpha = pcall(require, "alpha")
if not status then
    vim.notify("not found alpha") -- 如果未找到插件，则通知用户
    return
end

-- 获取一些 Neovim API 函数
local api, fn, fs = vim.api, vim.fn, vim.fs

--- @type function
local generate_config

-- 设置项目代码的基本路径
local project_path = "~/code"

--- @alias alpha_config_position "left"|"center"|"right"

--- @type alpha_config_position
local header_position = "center" -- 头部位置
--- @type alpha_config_position
local project_position = "center" -- 项目位置
--- @type alpha_config_position
local button_position = "center" -- 按钮位置

-- 设置 Neovim 启动屏幕 logo 的高亮颜色
vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = "#DA4939" })
vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = "#FF875F" })
vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = "#FFC66D" })
vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = "#00FF03" })
vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = "#00AFFF" })
vim.api.nvim_set_hl(0, "NeovimDashboardLogo6", { fg = "#8800FF" })

-- 启动画面 logo 内容
local header_content = {
    " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
}
-- 定义对应的高亮样式
local header_hl = {
    "NeovimDashboardLogo1",
    "NeovimDashboardLogo2",
    "NeovimDashboardLogo3",
    "NeovimDashboardLogo4",
    "NeovimDashboardLogo5",
    "NeovimDashboardLogo6",
}

-- 创建启动画面头部内容的函数
local function Makeheader()
    local tbl = {}
    for i, v in ipairs(header_content) do
        tbl[i] = {
            type = "text",
            val = v,
            opts = { hl = header_hl[i], shrink_margin = false, position = header_position },
        }
    end
    return { type = "group", val = tbl } -- 返回一个包含所有头部内容的组
end

local header = Makeheader() -- 生成头部内容

--- @param key string
--- @param txt string
--- @param position string
--- @param callback function? optional
--- @param retain boolean?
-- 创建按钮的函数
local function button(key, txt, position, callback, retain)
    local sc_ = key:gsub("%s", ""):gsub("SPC", "<leader>") -- 转换快捷键格式

    local opts = {
        position = position, -- 按钮位置
        shortcut = "[" .. key .. "] ", -- 按钮快捷键提示
        cursor = position == "left" and 1 or 2, -- 设置光标位置
        width = 50, -- 按钮宽度
        align_shortcut = (position == "left" and "left" or "right"), -- 短信位置
        hl_shortcut = "Keyword", -- 短信高亮
    }

    -- 按钮按下后的行为
    local function on_press()
        if callback then
            if not retain then
                vim.api.nvim_buf_delete(0, {}) -- 删除当前缓冲区
            end
            callback() -- 执行回调函数
        end
    end

    local keybind_opts = { noremap = true, silent = true, nowait = true, callback = on_press }
    opts.keymap = { "n", sc_, "", keybind_opts } -- 按钮的按键绑定

    return {
        type = "button", -- 按钮类型
        val = txt, -- 按钮文本
        on_press = on_press, -- 按钮按下事件
        opts = opts, -- 按钮选项
    }
end

-- 创建项目按钮的函数
local function projects()
    local path = fn.expand(project_path) -- 展开项目路径
    local iterator = fs.dir(path) -- 获取目录迭代器
    local tbl, index = {}, 0 -- 初始化表和索引

    while true do
        local filename, type = iterator() -- 获取文件名和类型
        if not filename then
            break -- 如果没有更多文件，退出循环
        end
        if type == "directory" then
            -- 创建项目按钮
            tbl[index] = button(tostring(index), string.format(" %s", filename), project_position, function()
                local path1 = string.format("%s/%s", project_path, filename) -- 构建完整路径
                local path2 = fn.expand(path1) -- 展开路径
                api.nvim_set_current_dir(path2) -- 设置当前目录
            end)
            index = index + 1 -- 索引递增
        end
    end

    return { type = "group", val = tbl } -- 返回包含所有项目按钮的组
end

local section_project = {
    type = "group",
    val = {
        {
            type = "text",
            val = " Projects ", -- 显示项目标题
            opts = {
                hl = "SpecialComment", -- 设置高亮样式
                shrink_margin = false,
                position = project_position, -- 设置位置
            },
        },
        { type = "padding", val = 1 }, -- 添加空白
        {
            type = "group",
            val = function()
                return { projects() } -- 返回项目按钮组
            end,
            opts = { shrink_margin = false },
        },
    },
}

-- 定义快速链接按钮
local buttons = {
    type = "group",
    val = {
        { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = button_position } }, -- 快速链接标题
        { type = "padding", val = 1 }, -- 添加空白
        button("e", " New file", button_position, function() -- 新建文件按钮
            vim.cmd([[ene]]) -- 执行新建缓冲区命令
        end),
        button("c", " Configuration", button_position, function() -- 配置文件按钮
            local config_path = vim.fn.stdpath("config") -- 获取配置路径
            ---@diagnostic disable-next-line: param-type-mismatch
            vim.fn.chdir(config_path) -- 切换到配置目录
            vim.api.nvim_command("bdelete") -- 删除当前缓冲区
        end),
        button("u", " Update plugins", button_position, function() -- 更新插件按钮
            vim.cmd([[Lazy sync]]) -- 执行更新插件命令
        end),
    },
}

-- 定义主题布局
local theme = {
    layout = {
        { type = "padding", val = 2 }, -- 添加顶部空白
        header, -- 添加头部内容
        { type = "padding", val = 2 }, -- 添加空白
        section_project, -- 添加项目部分
        { type = "padding", val = 2 }, -- 添加空白
        buttons, -- 添加快速链接按钮
    },
    opts = {
        margin = 5, -- 设置边距
    },
}

alpha.setup(theme) -- 设置 alpha 的主题

