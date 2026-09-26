--
-- Safe to run twice
--
vim.bo.commentstring = "# %s"

--
-- Guard
--
if vim.b.did_ftplugin_asm then
    return
end
vim.b.did_ftplugin_asm = true
