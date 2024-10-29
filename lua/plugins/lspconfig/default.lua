-- 尝试安全加载 cmp_nvim_lsp 插件
local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
    vim.notify("not found cmp_nvim_lsp") -- 如果加载失败，显示通知
    return -- 退出配置
end

-- 获取默认的能力配置，这些能力将会传递给 LSP 服务器
local capabilities = cmp_nvim_lsp.default_capabilities()

-- 为 Ufo 插件设置折叠范围能力
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false, -- 关闭动态注册
    lineFoldingOnly = true, -- 仅支持行折叠
}

-- 定义一个默认的配置构建器函数
local function default_confit_builder()
    -- local init_config = true -- 可以用于初始化配置的标志（注释掉了）

    -- LSP 配置选项
    local opt = {
        capabilities = capabilities, -- 设置能力
        flags = {
            debounce_text_changes = 150, -- 文本更改的防抖时间（150毫秒）
        },
        --- @param client vim.lsp.Client
        --- @param bufnr integer
        on_attach = function(client, bufnr)
            -- 禁用 LSP 服务器的格式化功能，交给其他插件处理
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            -- 绑定快捷键
            require("plugins.lspconfig.keybind").mapLSP(bufnr) -- 调用自定义的按键绑定函数
        end,
    }

    return opt -- 返回配置选项
end

-- vim.notify("lsp默认配置加载成功")

return default_confit_builder -- 导出默认配置构建器

