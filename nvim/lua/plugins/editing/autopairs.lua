return {
	--- Quality of life stuff
	-- auto add the ending bracket
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup {
				enable_check_bracket_line = false
			}
		end
	},
	{
		'windwp/nvim-ts-autotag',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				autotag = {
					enable = true,
				}
			}
		end
	},

}
