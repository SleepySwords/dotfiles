return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        image = {
            -- convert = {
            --     magick = {
            --         math = { "-density", 96 * 8, "{src}[0]" }
            --     }
            -- },
            math = {
                enabled = true, -- enable math expression rendering
                -- in the templates below, `${header}` comes from any section in your document,
                -- between a start/end header comment. Comment syntax is language-specific.
                -- * start comment: `// snacks: header start`
                -- * end comment:   `// snacks: header end`
                typst = {
                    tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 10pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
                },
                latex = {
                    font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
                    -- for latex documents, the doc packages are included automatically,
                    -- but you can add more packages here. Useful for markdown documents.
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
