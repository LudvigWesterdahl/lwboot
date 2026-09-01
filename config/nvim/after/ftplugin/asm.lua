if vim.b.did_ftplugin_asm then
    return
end
vim.b.did_ftplugin_asm = true

vim.bo.commentstring = "# %s"
