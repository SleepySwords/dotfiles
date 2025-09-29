-- Based on Eviline config for lualine
-- Original Author: shadmansaleh
-- Original Credit: glepnir

-- local lualine = require('lualine')
local lsp_status = require('lsp-status')
local navic = require('nvim-navic')

local conditions = require('heirline.conditions')

local diagnostic_signs = require('completion.diagnostic_signs')

local colour_util = require('utils.colours')
local colour_to_hex = colour_util.tuple_to_hex
local shade = colour_util.shade
local get_colour_tuple = colour_util.get_colour_tuple
local contrast = colour_util.contrast

local M = {}

function M.setup()
    local colours = {
        component_bg = colour_to_hex(shade(get_colour_tuple('Normal', 'bg'), 0.93)),
        text_bg = colour_to_hex(shade(get_colour_tuple('Normal', 'bg'), 0.8)),
        darker_bg = colour_to_hex(shade(get_colour_tuple('Normal', 'bg'), 0.6)),
        darker_fg = colour_to_hex(contrast(get_colour_tuple('Normal', 'fg'), 0.7)),
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

    local function get_next_colour(diag, severity)
        if severity == 'WARN' then
            if diag.errors > 0 then
                return colours.red
            else
                return colours.text_bg
            end
        end
        if severity == 'HINT' then
            if diag.warns > 0 then
                return colours.yellow
            elseif diag.errors > 0 then
                return colours.red
            else
                return colours.text_bg
            end
        end
        if severity == 'INFO' then
            if diag.hints > 0 then
                return colours.green
            elseif diag.warns > 0 then
                return colours.yellow
            elseif diag.errors > 0 then
                return colours.red
            else
                return colours.text_bg
            end
        end
        if severity == 'STATUS' then
            if diag.infos > 0 then
                return colours.blue
            elseif diag.hints > 0 then
                return colours.green
            elseif diag.warns > 0 then
                return colours.yellow
            elseif diag.errors > 0 then
                return colours.red
            else
                return colours.text_bg
            end
        end
    end

    local mode = {
        static = {
            -- auto change color according to neovims mode
            mode_color = {
                n = colours.green,
                i = colours.yellow,
                v = colours.purple,
                [''] = colours.red,
                V = colours.orange,
                c = colours.blue,
                no = colours.red,
                s = colours.blue,
                S = colours.blue,
                [''] = colours.orange,
                ic = colours.yellow,
                R = colours.violet,
                Rv = colours.violet,
                cv = colours.red,
                ce = colours.red,
                r = colours.cyan,
                rm = colours.cyan,
                ['r?'] = colours.cyan,
                ['!'] = colours.red,
                t = colours.red,
                nt = colours.blue,
            },
            mode_names = {
                n = 'NORMAL',
                i = 'INSERT',
                v = 'VISUAL',
                [''] = 'V-BLOCK',
                V = 'V-LINE',
                c = 'COMMAND',
                no = 'OPERATOR',
                s = 'S-CHARACTER',
                S = 'S-LINE',
                [''] = 'S-BLOCK',
                ic = 'I-COMPLETION',
                R = 'REPLACE',
                Rv = 'V-REPLACE',
                cv = 'EX-MODE',
                ce = 'RED',
                r = 'HIT-ENTER',
                rm = 'MORE',
                ['r?'] = 'CONFIRM',
                ['!'] = 'SHELL',
                t = 'TERMINAL',
                nt = 'SCRATCH',
            },
        },
        provider = function(self)
            if self.mode_names[self.mode] == nil then
                return '  ' .. string.format('NOT ADDED %s', self.mode) .. ' '
            else
                return '  ' .. self.mode_names[self.mode] .. ' '
            end
        end,
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,
        hl = function(self)
            return { fg = self.mode_color[self.mode] or colours.violet, bg = colours.component_bg }
        end,
        update = {
            'ModeChanged',
            pattern = '*:*',
            callback = vim.schedule_wrap(function()
                vim.cmd('redrawstatus')
            end),
        },
    }

    local venn_mode = {
        provider = function()
            return 'VENN MODE '
        end,
        condition = function()
            return vim.b.venn_enabled
        end,
        hl = function()
            return { fg = colours.violet, bg = colours.component_bg }
        end,
    }

    -- FIXME: to git
    local branch = {
        provider = function(self)
            return ' ' .. self.status_dict.head
        end,
    }

    local add_changes = {
        provider = function(self)
            local count = self.status_dict.added or 0
            return ('+' .. count)
        end,
        hl = { fg = colours.green },
    }

    local removed_changes = {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return ('-' .. count)
        end,
        hl = { fg = colours.red },
    }

    local modified_changes = {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return ('~' .. count)
        end,
        hl = { fg = colours.orange },
    }

    local left = {
        provider = '(',
    }

    local comma = {
        provider = ', ',
    }

    local right = {
        provider = ')',
    }

    local space = {
        provider = ' ',
    }

    local block = {
        provider = '█',
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    local align = {
        provider = '%=',
    }

    local diff = {
        {
            left,
            add_changes,
            comma,
            removed_changes,
            comma,
            modified_changes,
            right,
        },
    }

    local git = {
        { space, branch, diff, space },
        condition = conditions.is_git_repo,
        init = function(self)
            self.status_dict = vim.b.gitsigns_status_dict
            self.has_changes = self.status_dict.added ~= 0
                or self.status_dict.removed ~= 0
                or self.status_dict.changed ~= 0
        end,
        hl = { fg = colours.violet, bg = colours.component_bg, bold = true },
    }

    local diagnostic_error_sep = {
        provider = '',
        hl = { bg = colours.red, fg = colours.text_bg },
        condition = function(self)
            return self.errors > 0
        end,
    }

    local diagnostics_error = {
        provider = function(self)
            return ' ' .. self.error_sign .. self.errors .. ' '
        end,
        condition = function(self)
            return self.errors > 0
        end,
        hl = { bg = colours.red, fg = colours.icon_fg },
    }

    local diagnostic_warn_sep = {
        provider = function()
            return ''
        end,
        condition = function(self)
            return self.warns > 0
        end,
        hl = function(self)
            return {
                fg = get_next_colour(self, 'WARN'),
                bg = colours.yellow,
            }
        end,
    }

    local diagnostic_warn = {
        provider = function(self)
            return ' ' .. self.warn_sign .. self.warns .. ' '
        end,
        condition = function(self)
            return self.warns > 0
        end,
        hl = { bg = colours.yellow, fg = colours.icon_fg },
    }

    local diagnostic_hint_sep = {
        provider = function()
            return ''
        end,
        condition = function(self)
            return self.hints > 0
        end,
        hl = function(self)
            return {
                fg = get_next_colour(self, 'HINT'),
                bg = colours.green,
            }
        end,
    }

    local diagnostic_hint = {
        provider = function(self)
            return ' ' .. self.hint_sign .. self.hints .. ' '
        end,
        condition = function(self)
            return self.hints > 0
        end,
        hl = { bg = colours.green, fg = colours.icon_fg },
    }

    local diagnostic_info_sep = {
        provider = function()
            return ''
        end,
        condition = function(self)
            return self.infos > 0
        end,
        hl = function(self)
            return {
                fg = get_next_colour(self, 'INFO'),
                bg = colours.blue,
            }
        end,
    }

    local diagnostic_info = {
        provider = function(self)
            return ' ' .. self.info_sign .. self.infos .. ' '
        end,
        condition = function(self)
            return self.infos > 0
        end,
        hl = { bg = colours.blue, fg = colours.icon_fg },
    }

    local diagnostic_status_sep = {
        provider = function()
            return ''
        end,
        hl = function(self)
            return {
                fg = get_next_colour(self, 'STATUS'),
                bg = colours.magenta,
            }
        end,
    }

    local diagnostic_status = {
        provider = function()
            local progress = lsp_status.status_progress()
            if progress ~= '' then
                return ' ' .. progress .. ' '
            end
            return ' ' .. vim.g.indicator_ok .. ' '
        end,
        hl = { bg = colours.magenta, fg = colours.icon_fg },
    }

    local diagnostics = {
        {
            diagnostic_error_sep,
            diagnostics_error,
            diagnostic_warn_sep,
            diagnostic_warn,
            diagnostic_hint_sep,
            diagnostic_hint,
            diagnostic_info_sep,
            diagnostic_info,
            diagnostic_status_sep,
            diagnostic_status,
            {
                provider = '',
                hl = {
                    bg = colours.magenta,
                    fg = colours.text_bg,
                },
            },
        },
        static = {
            error_sign = diagnostic_signs[vim.diagnostic.severity.ERROR],
            warn_sign = diagnostic_signs[vim.diagnostic.severity.WARN],
            hint_sign = diagnostic_signs[vim.diagnostic.severity.HINT],
            info_sign = diagnostic_signs[vim.diagnostic.severity.INFO],
        },
        condition = function()
            return vim.tbl_count(vim.lsp.get_clients({ bufnr = 0 })) ~= 0
        end,
        init = function(self)
            self.errors = get_diagnostic(vim.diagnostic.severity.ERROR)
            self.warns = get_diagnostic(vim.diagnostic.severity.WARN)
            self.hints = get_diagnostic(vim.diagnostic.severity.HINT)
            self.infos = get_diagnostic(vim.diagnostic.severity.INFO)
        end,
    }

    local left_trig = {
        provider = '',
    }

    local lsp = {
        -- Lsp server name .
        provider = function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if next(clients) == nil then
                return ''
            end
            for _, client in ipairs(clients) do
                return '  ' .. client.name
            end
        end,
        condition = function()
            return vim.tbl_count(vim.lsp.get_clients({ bufnr = 0 })) ~= 0
        end,
        hl = { fg = colours.magenta, bg = colours.component_bg },
    }

    local filetype = {
        {
            {
                init = function(self)
                    local icon, colour =
                        require('nvim-web-devicons').get_icon_by_filetype(vim.bo.filetype)
                    self.icon = icon
                    self.colour = colour
                end,
                provider = function(self)
                    return self.icon
                end,
                hl = function(self)
                    return self.colour
                end,
            },
            space,
            {
                provider = function()
                    return vim.bo.filetype
                end,
            },
        },
        hl = { fg = colours.red, bg = colours.component_bg },
    }

    local encoding = {
        provider = function()
            return vim.bo.fenc ~= '' and vim.bo.fenc:upper() or vim.o.fenc:upper()
        end,
        hl = { fg = colours.orange, bg = colours.component_bg, italic = true },
    }

    local macro = {
        provider = function()
            return "Recording @" .. vim.fn.reg_recording()
        end,
        hl = { fg = colours.yellow, bg = colours.component_bg, bold = true },
        condition = function()
            return vim.fn.reg_recording() ~= ""
        end
    }

    local show_mode = {
        {
            provider = function()
                return vim.api.nvim_eval_statusline('%S', { highlights = true }).str
            end,
            update = function()
                return vim.api.nvim_eval_statusline('%S', {}).str ~= ''
                    and string.sub(vim.api.nvim_eval_statusline('%S', {}).str, 1, 1) ~= '~'
            end,
            hl = { fg = colours.magenta, bg = colours.component_bg, bold = true },
        },
        block,
        block,
        condition = function()
            return vim.o.showcmdloc == 'statusline'
        end,
    }

    local position = {
        provider = '%l:%c',
        hl = { fg = colours.green, bg = colours.component_bg, bold = true },
    }

    local percentage = {
        provider = '%P',
        hl = { fg = colours.blue, bg = colours.component_bg, bold = true },
    }

    local navic_win = {
        provider = function()
            return navic.get_location()
        end,
        condition = function()
            return navic.is_available()
        end,
    }
    local neovide_fix = {
        provider = function()
            return '%#Winbar# '
        end,
    }

    -- FIXME: use webicons like
    -- https://github.com/famiu/feline.nvim/blob/master/lua/feline/providers/file.lua#L85C38-L89C1
    local filename = {
        provider = ' %m %f ',
        hl = { bg = colours.text_bg, fg = colours.magenta },
    }

    local bufferlineActive = {
        provider = function(self)
            if self.is_active then
                return '█'
            else
                return ' '
            end
        end,
        hl = { fg = colours.magenta },
    }

    local bufferlineName = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(self.bufnr)
            if not self.filename or self.filename == '' then
                self.filename = '[No Name]'
            else
                self.filename = vim.fn.fnamemodify(self.filename, ':t')
            end
        end,
        provider = function(self)
            return self.filename
        end,
    }

    local bufferlineIcon = {
        init = function(self)
            local file = vim.api.nvim_buf_get_name(self.bufnr)
            local icon, colour = require('nvim-web-devicons').get_icon_color(file)
            self.icon = icon
            self.colour = colour
        end,
        condition = function(self)
            return vim.api.nvim_buf_get_name(self.bufnr) ~= ''
        end,
        provider = function(self)
            return self.icon
        end,
        hl = function(self)
            return { fg = self.colour }
        end,
    }

    local bufferlineCloseSave = {
        init = function(self)
            self.is_modified = vim.api.nvim_get_option_value('modified', { buf = self.bufnr })
        end,
        provider = function(self)
            if self.is_modified then
                return '●'
            else
                return ''
            end
        end,
        hl = function(self)
            if self.is_modified then
                return { fg = colours.green, bold = false }
            end
        end,
        on_click = {
            callback = function(_, minwid, _, _)
                local is_modified = vim.api.nvim_get_option_value('modified', { buf = minwid })
                if is_modified then
                    vim.api.nvim_win_set_buf(0, minwid)
                    vim.cmd.redrawtabline()
                else
                    vim.api.nvim_buf_delete(minwid, {})
                    vim.cmd.redrawtabline()
                end
            end,
            minwid = function(self)
                return self.bufnr
            end,
            name = 'bufferline_close',
        },
    }

    local bufferlineBlock = {
        on_click = {
            callback = function(_, minwid, _, _)
                vim.api.nvim_win_set_buf(0, minwid)
            end,
            minwid = function(self)
                return self.bufnr
            end,
            name = 'bufferline',
        },
        {
            bufferlineActive,
            space,
            space,
            bufferlineIcon,
            space,
            bufferlineName,
            space,
            space,
            bufferlineCloseSave,
            space,
        },
        hl = function(self)
            if self.is_active then
                return 'Normal'
            else
                return { bg = colours.text_bg, fg = colours.darker_fg }
            end
        end,
    }

    local tablineBlock = {
        static = {
            tabs = {
                'main',
                'debug',
            },
        },
        provider = function(self)
            local name = self.tabs[self.tabnr] or self.tabnr
            return ' ' .. name .. ' '
        end,
        hl = function(self)
            if self.is_active then
                return 'Normal'
            else
                return { bg = colours.text_bg, fg = colours.darker_fg }
            end
        end,
        on_click = {
            callback = function(_, minwid, _, _)
                vim.api.nvim_set_current_tabpage(minwid)
            end,
            minwid = function(self)
                return self.tabpage
            end,
            name = 'heirline_tabpage',
        },
    }

    -- local bufferline = utils.make_buflist(
    --     bufferlineBlock,
    --     { provider = ' ', hl = { fg = 'gray' } },
    --     { provider = ' ', hl = { fg = 'gray' } }
    -- )

    -- local tabline = utils.make_tablist(tablineBlock)

    local disable_winbar_cb = function(args)
        return conditions.buffer_matches({
            buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
            filetype = { '^git.*', 'fugitive', 'Trouble', 'dashboard' },
        }, args.buf) or args.file:find("rest_nvim_result") ~= nil
    end

    require('heirline').setup({
        ---@diagnostic disable-next-line missing-fields
        statusline = {
            {
                mode,
                venn_mode,
                git,
            },
            align,
            diagnostics,
            align,
            {
                {
                    left_trig,
                    block,
                    {
                        {
                            lsp,
                            block,
                            block,
                        },
                        condition = function()
                            return vim.tbl_count(vim.lsp.get_clients({ bufnr = 0 })) ~= 0
                        end,
                    },
                    {
                        filetype,
                        block,
                        block,
                        encoding,
                        block,
                        block,
                        condition = function()
                            return vim.api.nvim_buf_get_name(0) ~= ''
                        end,
                    },
                    {
                        macro,
                        block,
                        condition = function()
                            return vim.fn.reg_recording() ~= ""
                        end
                    },
                    show_mode,
                    position,
                    block,
                    block,
                    percentage,
                },
            },
            hl = {
                fg = colours.component_bg,
                bg = colours.text_bg,
            },
        },
        ---@diagnostic disable-next-line missing-fields
        winbar = {
            navic_win,
            align,
            filename,
            neovide_fix,
            hl = 'Normal',
        },
        -- tabline = {
        --     bufferline,
        --     align,
        --     {
        --         tabline,
        --         condition = function()
        --             return #vim.api.nvim_list_tabpages() >= 2
        --         end,
        --     },
        --     hl = { bg = colours.text_bg },
        -- },
        opts = {
            -- if the callback returns true, the winbar will be disabled for that window
            -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
            disable_winbar_cb = disable_winbar_cb,
        },
    })
end

return M
