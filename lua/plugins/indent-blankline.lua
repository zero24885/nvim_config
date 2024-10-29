-- 安全加载 indent-blankline.nvim 插件
local status, indent_blankline = pcall(require, "ibl")
if not status then
    vim.notify("indent-blankline.nvim not found")
    return
end


-- 插件配置
indent_blankline.setup({
	exclude = {
		filetypes = {
			"lspinfo",
			"packer",
			"checkhealth",
			"help",
			"man",
			"gitcommit",
			"TelescopePrompt",
			"TelescopeResults",
			"",
			"dashboard",
		},
    }
})

--vim.notify("indent-blankline加载完成")
