local list = require("plugins.lspconfig.list") -- 引入语言服务器配置列表
local lspconfig = require("lspconfig") -- 引入 LSP 配置插件
local mason_lspconfig = require("mason-lspconfig") -- 引入与 mason 结合的 LSP 配置插件

local alones = {} -- 存放独立服务器的列表
local servers = {} -- 存放普通服务器的列表
local installServers = {} -- 存放需要安装的服务器列表

local default_config = require("plugins.lspconfig.default") -- 引入默认配置

-- 遍历服务器列表，确定哪些需要安装和配置
for _, ele in pairs(list) do
    if ele.enable == nil or ele.enable then -- 如果没有显式禁用
        table.insert(installServers, ele.name) -- 添加到安装列表
        if ele.alone then -- 如果是独立服务器
            table.insert(alones, ele.name) -- 添加到独立服务器列表
        else
            table.insert(servers, ele.name) -- 否则添加到普通服务器列表
        end
    end
end

local servers_handlers = {} -- 存放服务器的处理函数

-- 为普通服务器定义处理函数
for _, value in pairs(servers) do
    local status, config = pcall(require, "plugins.lspconfig.config." .. value) -- 尝试加载配置
    if not status then
        config = {} -- 如果加载失败，使用空配置
    end
    servers_handlers[value] = function()
        lspconfig[value].setup(vim.tbl_deep_extend("force", default_config(), config)) -- 设置服务器
    end
end

-- 配置 mason-lspconfig
mason_lspconfig.setup({
    ensure_installed = installServers, -- 确保安装指定的服务器
    handlers = servers_handlers, -- 注册处理函数
})

-- 单独配置独立服务器
for _, ele in pairs(alones) do
    require("plugins.lspconfig.config." .. ele) -- 加载独立服务器的配置
end

-- vim.notify("lsp语言服务器初始化完成")
