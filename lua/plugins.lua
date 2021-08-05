return require('packer').startup(function()
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'bkad/CamelCaseMotion'
    use 'bkad/vim-terraform'
    use 'bkad/vim-coffee-script'
    use 'preservim/nerdcommenter'
    use 'gregsexton/MatchTag'
    use 'hdima/python-syntax'
    use {
	    'garbas/vim-snipmate',
	    requires = {
		    { 'tomtom/tlib_vim' },
		    { 'MarcWeber/vim-addon-mw-utils' },
		}
	}
    use 'tpope/vim-repeat'
	use 'HerringtonDarkholme/yats.vim'
	use 'fatih/vim-go'
    use 'nathanaelkane/vim-indent-guides'
	use 'jason0x43/vim-js-indent'
	use 'plasticboy/vim-markdown'
    use 'cespare/vim-toml'
	use 'editorconfig/editorconfig-vim'
	use {
		'junegunn/fzf',
		run = function() vim.fn['fzf#install'](0) end,
		requires = { 'junegunn/fzf.vim' },
	}
	use 'neovim/nvim-lspconfig'
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-lua/popup.nvim' },
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
		}
	}
	use 'hrsh7th/nvim-compe'
end)
