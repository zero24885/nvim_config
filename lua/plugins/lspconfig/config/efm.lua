--- @param name string
--- @param command string?
local function get_efm_config(name, command)
    -- 如果没有提供命令，则使用名称作为命令
    local cmd = command or name

    -- 检查在 NixOS 上是否可执行命令
    if isNixos() and not check_exec(cmd) then
        return
    end

    -- 尝试加载指定的 linter 配置
    local status, config = pcall(require, string.format("efmls-configs.linters.%s", name))
    if not status then
        -- 如果没有找到配置，发出通知并返回空表
        vim.notify(string.format("not found %s", name))
        return {}
    end
    return config
end

-- 获取样式检查器的配置
local stylelint = get_efm_config("stylelint")

-- 定义支持的语言和对应的 linter 配置
local languages = {
    javascript = {
        -- 当前 NixOS 不支持此 linter
        get_efm_config("js_standard"),
    },
    css = {
        stylelint,  -- 使用 stylelint 进行 CSS 检查
    },
    dockerfile = {
        get_efm_config("hadolint"),  -- 使用 hadolint 进行 Dockerfile 检查
    },
    go = {
        get_efm_config("golangci_lint", "golangci-lint"),  -- 使用 golangci-lint 进行 Go 语言检查
    },
    python = {
        get_efm_config("pylint"),  -- 使用 pylint 进行 Python 检查
    },
    markdown = {
        get_efm_config("markdownlint"),  -- 使用 markdownlint 进行 Markdown 检查
        get_efm_config("alex"),  -- 使用 alex 进行 Markdown 检查
    },
    yaml = {
        get_efm_config("actionlint"),  -- 使用 actionlint 进行 YAML 检查
        get_efm_config("yamllint"),  -- 使用 yamllint 进行 YAML 检查
    },
    less = {
        stylelint,  -- 使用 stylelint 进行 LESS 检查
    },
    sass = {
        stylelint,  -- 使用 stylelint 进行 SASS 检查
    },
    scss = {
        stylelint,  -- 使用 stylelint 进行 SCSS 检查
    },
    vim = {
        get_efm_config("vint"),  -- 使用 vint 进行 Vim 脚本检查
    },
}

-- 定义 EFM 配置选项
local opt = {
    filetypes = vim.tbl_keys(languages),  -- 支持的文件类型
    settings = {
        rootMarkers = { ".git" },  -- 根目录标识符
        languages = languages,  -- 语言及其配置
    },
    init_options = {
        documentFormatting = false,  -- 禁用文档格式化
        documentRangeFormatting = false,  -- 禁用文档范围格式化
    },
    single_file_support = true,  -- 支持单文件模式
}

return opt  -- 返回 EFM 配置选项

