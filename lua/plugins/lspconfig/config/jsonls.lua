-- 尝试安全加载 schemastore 插件
local status, schemastore = pcall(require, "schemastore")
if not status then
    vim.notify("not found schemastore") -- 如果加载失败，显示通知
    return -- 退出配置
end

-- 定义配置选项
local opt = {
    settings = {
        schemas = schemastore.json.schemas(), -- 从 schemastore 获取 JSON 模式
    },
}

return opt -- 返回配置选项

