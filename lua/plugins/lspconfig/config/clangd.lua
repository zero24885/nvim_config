-- 创建一个表，用于存储 clangd 的配置选项
local opt = {
    -- 设置语言服务器的命令和参数
    cmd = { "clangd", "--offset-encoding=utf-16" }, -- 指定要使用的命令和参数，clangd 是 C/C++ 的语言服务器，--offset-encoding=utf-16 指定使用 UTF-16 编码进行偏移
    -- 定义根目录的获取方法
    root_dir = function()
        return vim.fn.getcwd() -- 返回当前工作目录作为项目根目录
    end,
}

-- 返回配置选项表
return opt

