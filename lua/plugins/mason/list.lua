-- 这个列表将用于 efm-langserver 和 conform，包含多个代码格式化和静态分析工具
return {
    -- Conform 工具（用于代码格式化）
    "clang-format",              -- C/C++ 代码格式化工具
    -- "gofumpt",                   -- Go 语言格式化工具，提供一致的代码风格
    -- "goimports-reviser",         -- Go 语言工具，自动调整导入语句
    "prettierd",                 -- Prettier 的守护进程，支持多种语言（如 JSX、Angular、TypeScript 等）
    "stylua",                    -- Lua 代码格式化工具
    "shfmt",                     -- Shell 脚本格式化工具
    "black",                     -- Python 代码格式化工具，提供一致的代码风格
    "isort",                     -- Python 工具，负责排序导入语句
    "yamlfmt",                   -- YAML 文件格式化工具
    "xmlformatter",              -- XML 文件格式化工具
    "cbfmt",                     -- C++ 代码格式化工具（具体工具可根据需求替换）

    -- EFM 工具（用于静态代码分析）
    "hadolint",                  -- Dockerfile 语法检查工具
    "markdownlint",              -- Markdown 文件的语法检查工具
    "pylint",                    -- Python 代码的静态检查工具
    "actionlint",                -- GitHub Actions 的语法检查工具
    "alex",                      -- 检查文本中的不当用语的工具
    -- "golangci-lint",             -- Go 语言的多个静态分析工具的集合
    "standardjs",                -- JavaScript 代码的静态检查工具
    -- "stylelint",                 -- CSS 代码的静态检查工具
    "vint",                      -- Vim 脚本的静态分析工具
    "yamllint",                  -- YAML 文件的语法检查工具
}

