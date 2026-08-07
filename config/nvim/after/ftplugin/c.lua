if vim.b.did_ftplugin_c then
    return
end
vim.b.did_ftplugin_c = true

vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.commentstring = "/* %s */"
