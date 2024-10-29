-- 定义 Python 语言服务器的配置选项
local opt = {
    settings = {
        pylsp = { -- pylsp 是 Python 语言服务器的名称
            plugins = { -- 插件配置
                pycodestyle = { -- 代码风格检查插件
                    enabled = true, -- 启用插件
                    ignore = { "W391" }, -- 忽略的检查代码（此处为 "W391"，即空行的检查）
                    maxLineLength = 100, -- 最大行长度设置为 100
                },
                flake8 = { -- Flake8 代码检查工具
                    enabled = true, -- 启用 Flake8 插件
                },
                rope_autoimport = { -- Rope 插件用于自动导入
                    enabled = true, -- 启用自动导入功能
                },
                rope_completion = { -- Rope 插件的代码补全功能
                    enabled = true, -- 启用补全功能
                },
                jedi_completion = { -- Jedi 插件用于代码补全
                    fuzzy = true, -- 启用模糊匹配
                    eager = true, -- 启用急切加载
                },
                pylint = { -- Pylint 代码检查工具
                    enabled = true, -- 启用 Pylint 插件
                },
            },
        },
    },
}

return opt -- 返回配置选项

