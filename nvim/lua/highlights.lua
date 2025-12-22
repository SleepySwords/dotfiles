-- Custom highlights

vim.api.nvim_set_hl(0, 'InlaySurround', { fg = '#2d2b46' })

local colour_util = require('utils.colours')
local tuple_to_hex = colour_util.tuple_to_hex
local contrast = colour_util.contrast
local contrast_based_on = colour_util.contrast_based_on
local lightness = colour_util.lightness
local get_colour_tuple = colour_util.get_colour_tuple

local inlay_bg = contrast(get_colour_tuple('normal', 'bg'), 0.98)
local inlay_fg = contrast(get_colour_tuple('normal', 'bg'), 0.50)

vim.api.nvim_set_hl(
    0,
    'LspInlayHint',
    { bg = tuple_to_hex(inlay_bg), fg = tuple_to_hex(inlay_fg), italic = true }
-- { fg = tuple_to_hex(inlay_fg), italic = true }
)

-- This is for the trail listchar
vim.api.nvim_set_hl(0, 'Whitespace', {
    fg = vim.api.nvim_get_hl(0, { name = 'Whitespace', link = false })['fg'],
    bg = vim.api.nvim_get_hl(0, { name = 'Whitespace', link = false })['bg'],
    underline = true,
})

vim.api.nvim_set_hl(0, 'Folded', {})
vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'UfoFoldedBg', {})

vim.api.nvim_set_hl(0, 'TelescopeSelection', { link = 'Define' })
vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'TelescopeMatching', { bold = true, fg = '#f6c177' })
-- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = tuple_to_hex(inlay_bg) })
-- vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = tuple_to_hex(inlay_bg) })
vim.api.nvim_set_hl(0, 'QuickFixLineNr', { link = 'Delimiter' })

local is_light = lightness(get_colour_tuple('normal', 'bg')) > 0.5

local headline1 = tuple_to_hex(
    contrast_based_on(get_colour_tuple('@markup.heading.1.markdown', 'fg'), 0.3, is_light)
)
local headline2 = tuple_to_hex(
    contrast_based_on(get_colour_tuple('@markup.heading.2.markdown', 'fg'), 0.3, is_light)
)
local headline3 = tuple_to_hex(
    contrast_based_on(get_colour_tuple('@markup.heading.3.markdown', 'fg'), 0.3, is_light)
)
local headline4 = tuple_to_hex(
    contrast_based_on(get_colour_tuple('@markup.heading.4.markdown', 'fg'), 0.3, is_light)
)

local code_bg =
    tuple_to_hex(contrast_based_on(get_colour_tuple('normal', 'bg'), 0.95, not is_light))
vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = code_bg })

vim.api.nvim_set_hl(0, 'Headline1', { bg = headline1 })
vim.api.nvim_set_hl(0, 'Headline2', { bg = headline2 })
vim.api.nvim_set_hl(0, 'Headline3', { bg = headline3 })
vim.api.nvim_set_hl(0, 'Headline4', { bg = headline4 })

local visual_colour = is_light and '#555555' or '#FFFFFF'

-- vim.api.nvim_set_hl(0, "Cursor", {fg="#ebbab9"})

vim.api.nvim_set_hl(0, 'Visual', {
    bg = vim.api.nvim_get_hl(0, { name = 'Visual', link = false }).bg,
    fg = visual_colour,
    bold = true,
})

vim.api.nvim_set_hl(0, 'GitGraphBranch1', { fg = '#458588' })
vim.api.nvim_set_hl(0, 'GitGraphBranch2', { fg = '#b16286' })
vim.api.nvim_set_hl(0, 'GitGraphBranch3', { fg = '#d79921' })
vim.api.nvim_set_hl(0, 'GitGraphBranch4', { fg = '#98971a' })
vim.api.nvim_set_hl(0, 'GitGraphBranch5', { fg = '#d5651c' })

-- normal_float = vim.api.nvim_get_hl(0, { name = 'NormalFloat', link = false })
-- vim.api.nvim_set_hl(0, 'WhichKeyNormal', {
--     bg = normal_float.bg,
--     fg = normal_float.fg,
-- })
--
-- vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
