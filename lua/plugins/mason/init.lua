-- 尝试安全加载 mason 插件
local status, mason = pcall(require, "mason")
if not status then
    vim.notify("not found mason") -- 如果加载失败，显示通知
    return -- 退出配置
end

-- 引入自定义的列表
local list = require("plugins.mason.list") -- 这里假设自定义的插件列表存放在这个模块
local mason_registry = require("mason-registry") -- 引入 mason 的注册表

-- 初始化 mason
mason.setup()

-- 确保指定的语言服务器和工具已经安装
local ensure_installed = function()
    for _, name in pairs(list) do -- 遍历自定义列表中的每一个名称
        if not mason_registry.is_installed(name) then -- 检查是否已安装
            local package = mason_registry.get_package(name) -- 获取相应的包
            package:install() -- 安装包
        end
    end
end

-- 刷新 mason 注册表并确保安装所需的包
mason_registry.refresh(vim.schedule_wrap(ensure_installed)) -- 使用 vim.schedule_wrap 确保在合适的时间调用

-- vim.notify("mason插件加载完成")

-- 引入自定义的 LSP 配置
require("plugins.mason.lsp")

