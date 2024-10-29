-- 尝试安全加载 conform 插件
local status, conform = pcall(require, "conform")
if not status then
    vim.notify("not found conform") -- 如果插件未找到，发送通知
    return
end


local function isNixos()
    return vim.fn.system("uname") == "NixOS\n"
end

local function check_exec(cmd)
    local result = vim.fn.system("command -v " .. cmd)  -- 使用系统命令检查可执行命令
    return result ~= ""  -- 如果返回不为空，则说明命令可执行
end


--- 检查给定的命令是否可执行，并返回有效的格式化工具名称
--- @param list {name:string,cmd:string}[] -- 格式化工具的列表，每个工具包含名称和可选命令
--- @return string[] -- 返回可用格式化工具的名称列表
local check = function(list)
    local res = {} -- 存储可用的格式化工具名称
    for _, ele in pairs(list) do
        local cmd = ele.cmd or ele.name -- 如果指定了命令，则使用命令，否则使用名称
        -- 检查是否在 NixOS，或者命令是否可执行
        if not isNixos() or check_exec(cmd) then
            table.insert(res, ele.name) -- 将可用的格式化工具名称添加到结果列表
        end
    end
    return res -- 返回有效的工具名称列表
end

-- 配置 conform 插件
conform.setup({
    -- 为不同文件类型指定格式化工具
    formatters_by_ft = {
        c = check({
            { name = "clang_format" }, -- C 文件使用 clang_format
        }),
        cpp = check({
            { name = "clang_format" }, -- C++ 文件使用 clang_format
        }),
        go = check({
            { name = "gofumpt" }, -- Go 文件使用 gofumpt
            { name = "goimports-reviser" }, -- Go 文件使用 goimports-reviser
        }),
        html = check({
            { name = "prettierd" }, -- HTML 文件使用 prettierd
        }),
        json = check({
            { name = "prettierd" }, -- JSON 文件使用 prettierd
        }),
        jsonc = check({
            { name = "prettierd" }, -- JSONC 文件使用 prettierd
        }),
        rust = check({
            { name = "rustfmt" }, -- Rust 文件使用 rustfmt
        }),
        bash = check({
            { name = "shfmt" }, -- Bash 文件使用 shfmt
        }),
        lua = check({
            { name = "stylua" }, -- Lua 文件使用 stylua
        }),
        javascript = check({
            { name = "prettierd" }, -- JavaScript 文件使用 prettierd
        }),
        typescript = check({
            { name = "prettierd" }, -- TypeScript 文件使用 prettierd
        }),
        javascriptreact = check({
            { name = "prettierd" }, -- JavaScript React 文件使用 prettierd
        }),
        typescriptreact = check({
            { name = "prettierd" }, -- TypeScript React 文件使用 prettierd
        }),
        vue = check({
            { name = "prettierd" }, -- Vue 文件使用 prettierd
        }),
        python = check({
            { name = "isort" }, -- Python 文件使用 isort
            { name = "black" }, -- Python 文件使用 black
        }),
        zig = check({
            { name = "zigfmt", cmd = "zig" }, -- Zig 文件使用 zigfmt，命令为 zig
        }),
        markdown = check({
            { name = "prettierd" }, -- Markdown 文件使用 prettierd
            { name = "cbfmt" }, -- Markdown 文件使用 cbfmt
        }),
        yaml = check({
            { name = "yamlfmt" }, -- YAML 文件使用 yamlfmt
        }),
        xml = check({
            { name = "xmlformat" }, -- XML 文件使用 xmlformat
        }),
        nix = check({
            { name = "nixpkgs_fmt", cmd = "nixpkgs-fmt" }, -- Nix 文件使用 nixpkgs_fmt，命令为 nixpkgs-fmt
        }),
    },
})

