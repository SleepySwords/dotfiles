-- Based on Eviline config for lualine
-- Original Author: shadmansaleh
-- Original Credit: glepnir

local lualine = require('lualine')
local lsp_status = require('lsp-status')
local navic = require('nvim-navic')

local function colour_name_to_tuple(colour)
    return {
        red = bit.band(bit.rshift(colour, 16), 0xFF),
        green = bit.band(bit.rshift(colour, 8), 0xFF),
        blue = bit.band(colour, 0xFF),
    }
end

local function shade(colour, factor)
    return {
        red = colour.red * factor,
        green = colour.green * factor,
        blue = colour.blue * factor,
    }
end

local function colour_to_hex(colour)
    return '#'
        .. ('%X'):format(math.abs(colour.red))
        .. ('%X'):format(math.abs(colour.green))
        .. ('%X'):format(math.abs(colour.blue))
end

local colors = {
    component_bg = colour_to_hex(
        shade(colour_name_to_tuple(vim.api.nvim_get_hl(0, { name = 'normal' }).bg), 0.93)
    ),
    bg = colour_to_hex(
        shade(colour_name_to_tuple(vim.api.nvim_get_hl(0, { name = 'normal' }).bg), 0.8)
    ),
    fg = colour_to_hex(colour_name_to_tuple(vim.api.nvim_get_hl(0, { name = 'normal' }).fg)),
    icon_fg = '#12121a',
    yellow = '#ECBE7B',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#FF8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef',
    red = '#ec5f67',
}

local function get_diagnostic(severity)
    return #vim.diagnostic.get(0, { severity = severity })
end

local diagnostic_highlights = {
    error = vim.api.nvim_get_hl(0, { name = 'DiagnosticError', link = false }).fg,
    warn = vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn', link = false }).fg,
    info = vim.api.nvim_get_hl(0, { name = 'DiagnosticInfo', link = false }).fg,
    hint = vim.api.nvim_get_hl(0, { name = 'DiagnosticHint', link = false }).fg,
}

local function get_next_colour(severity)
    -- TODO: Factorise
    local diag = {
        error = get_diagnostic(vim.diagnostic.severity.ERROR),
        warn = get_diagnostic(vim.diagnostic.severity.WARN),
        info = get_diagnostic(vim.diagnostic.severity.INFO),
        hint = get_diagnostic(vim.diagnostic.severity.HINT),
    }
    if severity == 'WARN' then
        if diag.error > 0 then
            return colors.red
        else
            return colors.bg
        end
    end
    if severity == 'HINT' then
        if diag.warn > 0 then
            return colors.yellow
        elseif diag.error > 0 then
            return colors.red
        else
            return colors.bg
        end
    end
    if severity == 'INFO' then
        if diag.hint > 0 then
            return colors.green
        elseif diag.warn > 0 then
            return colors.yellow
        elseif diag.error > 0 then
            return colors.red
        else
            return colors.bg
        end
    end
    if severity == 'STATUS' then
        if diag.info > 0 then
            return colors.blue
        elseif diag.hint > 0 then
            return colors.green
        elseif diag.warn > 0 then
            return colors.yellow
        elseif diag.error > 0 then
            return colors.red
        else
            return colors.bg
        end
    end
end

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local mode = {
    -- mode component
    'mode',
    icon = '',
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.green,
            i = colors.yellow,
            v = colors.purple,
            [''] = colors.red,
            V = colors.orange,
            c = colors.blue,
            no = colors.red,
            s = colors.blue,
            S = colors.blue,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()], bg = colors.component_bg }
    end,
    separator = {
        left = '█',
        right = '█',
    },
    padding = 1,
}

-- FIXME: to git
local branch = {
    'branch',
    icon = '',
    color = { fg = colors.violet, bg = colors.component_bg, gui = 'bold' },
    padding = { right = 0, left = 1 },
}

local branch_left = {
    function()
        if
            vim.b.gitsigns_status_dict.added
            or vim.b.gitsigns_status_dict.changed
            or vim.b.gitsigns_status_dict.removed
        then
            return '('
        end
    end,
    color = { fg = colors.violet, bg = colors.component_bg, gui = 'bold' },
    padding = 0,
}

local branch_right = {
    function()
        if
            vim.b.gitsigns_status_dict.added
            or vim.b.gitsigns_status_dict.changed
            or vim.b.gitsigns_status_dict.removed
        then
            return ')'
        end
    end,
    color = { fg = colors.violet, bg = colors.component_bg, gui = 'bold' },
    padding = { right = 1, left = 0 },
}

local add_changes = {
    function()
        local count = vim.b.gitsigns_status_dict.added or 0
        return ('+' .. count)
    end,
    color = { fg = colors.green, bg = colors.component_bg, gui = 'bold' },
    padding = 0,
    separator = '',
}

local removed_changes = {
    function()
        local count = vim.b.gitsigns_status_dict.removed or 0
        return ('-' .. count)
    end,
    color = { fg = colors.red, bg = colors.component_bg, gui = 'bold' },
    padding = 0,
    separator = '',
}

local modified_changes = {
    function()
        local count = vim.b.gitsigns_status_dict.changed or 0
        return ('~' .. count)
    end,
    color = { fg = colors.orange, bg = colors.component_bg, gui = 'bold' },
    padding = 0,
    separator = '',
}

local comma = {
    function()
        if
            vim.b.gitsigns_status_dict.added
            or vim.b.gitsigns_status_dict.changed
            or vim.b.gitsigns_status_dict.removed
        then
            return ', '
        end
    end,
    color = { bg = colors.component_bg },
    padding = 0,
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
local align = {
    function()
        return '%='
    end,
    color = { bg = colors.status_bg },
}

local align_win = {
    function()
        return '%='
    end,
    color = { bg = 'Normal' },
}

local diagnostics_error = {
    'diagnostics',
    source = { 'nvim' },
    sections = { 'error' },
    diagnostics_color = { error = { bg = colors.red, fg = colors.icon_fg } },
    symbols = { error = ' ' },
    separator = { left = '' },
}

local diagnostic_warn_sep = {
    function()
        if get_diagnostic(vim.diagnostic.severity.WARN) > 0 then
            return ''
        end
        return ''
    end,
    padding = 0,
    separator = '',
    color = function()
        return {
            bg = get_next_colour('WARN'),
            fg = colors.yellow,
        }
    end,
}

local diagnostic_warn = {
    'diagnostics',
    source = { 'nvim' },
    sections = { 'warn' },
    diagnostics_color = { warn = { bg = colors.yellow, fg = colors.icon_fg } },
    symbols = { warn = ' ' },
    separator = '',
}

local diagnostic_hint_sep = {
    function()
        if get_diagnostic(vim.diagnostic.severity.HINT) > 0 then
            return ''
        end
        return ''
    end,
    padding = 0,
    separator = '',
    color = function()
        return {
            bg = get_next_colour('HINT'),
            fg = colors.green,
        }
    end,
}

local diagnostic_hint = {
    'diagnostics',
    source = { 'nvim' },
    sections = { 'hint' },
    diagnostics_color = { hint = { bg = colors.green, fg = colors.icon_fg } },
    symbols = { hint = ' ' },
    separator = '',
}

local diagnostic_info_sep = {
    function()
        if get_diagnostic(vim.diagnostic.severity.INFO) > 0 then
            return ''
        end
        return ''
    end,
    padding = 0,
    separator = '',
    color = function()
        return {
            bg = get_next_colour('INFO'),
            fg = colors.blue,
        }
    end,
}

local diagnostic_info = {
    'diagnostics',
    source = { 'nvim' },
    sections = { 'info' },
    diagnostics_color = { info = { bg = colors.blue, fg = colors.icon_fg } },
    symbols = { info = ' ' },
    separator = '',
}

local diagnostic_status_sep = {
    function()
        if vim.tbl_count(vim.lsp.buf_get_clients(0)) == 0 then
            return ''
        end
        return ''
    end,
    padding = 0,
    separator = '',
    color = function()
        return {
            bg = get_next_colour('STATUS'),
            fg = colors.magenta,
        }
    end,
}

local diagnostic_status = {
    function()
        if vim.tbl_count(vim.lsp.buf_get_clients(0)) == 0 then
            return ''
        end
        local progress = lsp_status.status_progress()
        if progress ~= '' then
            return progress
        end
        return vim.g.indicator_ok
    end,
    separator = { right = '' },
    color = { bg = colors.magenta, fg = colors.icon_fg },
}

local lsp = {
    -- Lsp server name .
    function()
        local msg = ''
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = '',
    color = { fg = colors.magenta, bg = colors.component_bg },
    separator = {
        left = '',
        right = '█',
    },
}

local filetype = {
    'filetype',
    color = { fg = colors.red, bg = colors.component_bg },
}

local encoding = {
    'o:encoding',
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.orange, gui = 'italic', bg = colors.component_bg },
}

local position = {
    'position',
    color = { fg = colors.green, gui = 'bold', bg = colors.component_bg },
}

local percentage = {
    'percentage',
    color = { fg = colors.blue, gui = 'bold', bg = colors.component_bg },
}

local status_bar = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {
        mode,
        branch,
        branch_left,
        add_changes,
        comma,
        removed_changes,
        comma,
        modified_changes,
        branch_right,
        align,
        diagnostics_error,
        diagnostic_warn_sep,
        diagnostic_warn,
        diagnostic_hint_sep,
        diagnostic_hint,
        diagnostic_info_sep,
        diagnostic_info,
        diagnostic_status_sep,
        diagnostic_status,
    },
    lualine_x = {
        lsp,
        filetype,
        encoding,
        position,
        percentage,
    },
}

local navic_win = {
    function()
        if navic.is_available() then
            return navic.get_location()
        else
            return ''
        end
    end,
    color = {
        bg = 'normal',
    },
}

-- FIXME: use webicons like
-- https://github.com/famiu/feline.nvim/blob/master/lua/feline/providers/file.lua#L85C38-L89C1
local filename = {
    'filename',
    color = { bg = colors.bg },
}

local winbar = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {
        navic_win,
        align_win,
        filename,
    },
    lualine_x = {},
}

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
    },
    sections = status_bar,
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
    winbar = winbar,
    inactive_winbar = winbar,
}

lualine.setup(config)
