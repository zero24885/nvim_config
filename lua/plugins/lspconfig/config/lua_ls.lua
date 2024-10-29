return {
    settings = {
        Lua = {
            -- 启用 Lua 语言服务器的提示功能
            hint = {
                enable = true,  -- 启用提示
                arrayIndex = "Disable",  -- 对数组索引的提示设置，可能是启用或禁用
                setType = true,  -- 是否设置类型提示
            },
            workspace = {
                -- 配置工作区的相关选项
                checkThirdParty = false,  -- 禁止检查第三方库的类型
            },
        },
    },
}

