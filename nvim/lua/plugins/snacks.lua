return {
    'folke/snacks.nvim',
    priority = 1000,
    branch = "main",
    lazy = false,
    keys = {
        { '<leader>az', function() Snacks.zen() end },
        { '<leader>g',  function() Snacks.lazygit() end, mode = 'n', desc = 'Open lazygit' }
    },
    opts = {
        zen = {
            toggles = {
                dim = false,
            }
        },
        lazygit = {
            config = {
                git = {
                    paging = {
                        pager = "delta --features \"nvim\" --paging=never"
                    }
                }
            }
        },
        image = {
            math = {
                enabled = false,
                typst = {
                    tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 10pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
                },
                latex = {
                    font_size = "Large",
                    packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
                    tpl = [[
        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
        \usepackage{${packages}}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
                },
            },
        }
    },
}
