local languages = {
	"lua",
	"vim",
	"bash",
	"vimdoc",
	"query",
	"hcl",
	"terraform",
	"python",
	"r",
	"xml",
	"awk",
	"bibtex",
	"comment",
	"csv",
	"diff",
	"dockerfile",
	"git_config",
	"gitcommit",
	"gitignore",
	"go",
	"gosum",
	"gomod",
	"jq",
	"latex",
	"markdown",
	"regex",
	"yaml",
}

-- nvim-treesitter's current API installs parsers and queries; highlighting and
-- folding are now provided by Neovim itself.
require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local parser_started = pcall(vim.treesitter.start, args.buf)
		if not parser_started then
			return
		end

		local winid = vim.fn.bufwinid(args.buf)
		if winid ~= -1 then
			vim.wo[winid].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[winid].foldmethod = "expr"
		end
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
