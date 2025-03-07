-- add functions and keybinding to disable autoformatting
vim.api.nvim_create_user_command("FormatToggle", function()
	local disable_autoformat = vim.b.disable_autoformat or false
	vim.b.disable_autoformat = not disable_autoformat
	if vim.b.disable_autoformat then
		print("Autoformatting is now disabled")
	else
		print("Autoformatting is now enabled")
	end
end, {
	desc = "[T]oggle autoformat-on-save",
})
vim.api.nvim_set_keymap("n", "<leader>ft", ":FormatToggle<CR>", { noremap = true, silent = true })
