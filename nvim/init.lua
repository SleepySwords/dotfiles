vim.loader.enable()

-- Bootstrapping Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('keybindings')
require('lazy').setup(
    {
        { import = 'plugins' },
        { import = 'plugins.themes' },
        { import = 'plugins.editing' },
        { import = 'plugins.editing.search' },
        { import = 'plugins.ui' },
        { import = 'plugins.ui.editor' },
        { import = 'plugins.ui.buffer' }
    })
require('autocmds')
require('settings')
require('highlights')
