-- 按理说这个不需要

-- 尝试安全加载 lspconfig 插件
local status, lspconfig = pcall(require, "lspconfig")
if not status then
    vim.notify("not found lspconfig") -- 如果加载失败，显示通知
    return -- 退出配置
end

-- 引入自定义的语言服务器列表
local list = require("plugins.lspconfig.list")

-- 引入默认的语言服务器配置
local default_config = require("plugins.lspconfig.default")

-- 遍历自定义列表中的每个语言服务器配置
for _, ele in pairs(list) do
    local cmd = ele.cmd or ele.name -- 获取命令，如果没有命令则使用名称
    if check_exec(cmd) then -- 检查该命令是否可以执行
        -- 尝试加载该语言服务器的特定配置
        local cmd_status, config = pcall(require, "plugins.lspconfig.config." .. ele.name)
        if not cmd_status then
            config = {} -- 如果加载失败，使用空配置
        end

        -- 设置语言服务器，合并默认配置和特定配置
        lspconfig[ele.name].setup(vim.tbl_deep_extend("force", default_config(), config))
    end
end

