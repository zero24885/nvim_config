--- @type { name:string, cmd:string?, alone:boolean, enable:boolean? }
local lists = {
    { cmd = "lua-language-server", name = "lua_ls", alone = false }, -- Lua 语言服务器，使用默认命令

    { name = "clangd", alone = false }, -- C/C++ 语言服务器，默认命令为 "clangd"

    { cmd = "bash-language-server", name = "bashls", alone = false }, -- Bash 语言服务器

    { name = "cmake", alone = false }, -- CMake 语言服务器

    { cmd = "vscode-css-language-server", name = "cssls", alone = false }, -- CSS 语言服务器

    { cmd = "docker-langserver", name = "dockerls", alone = false }, -- Docker 语言服务器

--    { cmd = "emmet-language-server", name = "emmet_ls", alone = false }, -- Emmet 语言服务器
--    { cmd = "gopls", name = "gopls", alone = false }, -- Go 语言服务器

    { cmd = "vscode-html-language-server", name = "html", alone = false }, -- HTML 语言服务器

    { cmd = "vscode-json-language-server", name = "jsonls", alone = false }, -- JSON 语言服务器

--    { name = "rust_analyzer", alone = false }, -- Rust 语言服务器

    { name = "basedpyright", alone = false }, -- 基于 Pyright 的 Python 语言服务器
--    { name = "volar", alone = false }, -- Vue 语言服务器

    { cmd = "vim-language-server", name = "vimls", alone = false }, -- Vim 语言服务器
--    { name = "vtsls", alone = false }, -- Vue TypeScript 语言服务器（待处理）
--    { name = "unocss", alone = false }, -- UnoCSS 语言服务器（待处理）
    
    { cmd = "yaml-language-server", name = "yamlls", alone = false }, -- YAML 语言服务器
    
    { name = "lemminx", alone = false }, -- XML 语言服务器
--    { name = "taplo", alone = false }, -- TOML 语言服务器
    
    { cmd = "efm-langserver", name = "efm", alone = false }, -- EFM 语言服务器，支持多种格式化工具
--    { cmd = "nil", name = "nil_ls", alone = false, enable = false }, -- NIL 语言服务器，默认禁用
--    { name = "zls", alone = false }, -- Zig 语言服务器
}

return lists

