-- plugin/autocomplete.lua

local function autocomplete_settings()

    -- Enable omnifunc for completion
    vim.o.completeopt = "menuone,noselect"

    -- Set omnifunc for LSP
    vim.api.nvim_exec([[
      augroup lsp
        autocmd!
        autocmd FileType * setlocal omnifunc=v:lua.vim.lsp.omnifunc
      augroup END
    ]], false)

    -- Automatically trigger completion as you type
    vim.cmd([[
      augroup auto_complete
        autocmd!
        autocmd InsertCharPre * if col('.') > 1 | call feedkeys("\<C-x>\<C-o>", 'n') | endif
      augroup END
    ]])
    
    -- Navigate completion options with <Tab> and <Shift-Tab>
    vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, expr = true, silent = true })
    vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { noremap = true, expr = true, silent = true })
    
    -- Enter to confirm completion without moving to a new line
    vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? "\\<C-y>" : "\\<CR>"', { noremap = true, expr = true, silent = true })

end

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'c', 'cpp', 'cuda', 'lua', 'sh' },
  desc = 'Configure autocomplete settings',
  callback = autocomplete_settings,
})
