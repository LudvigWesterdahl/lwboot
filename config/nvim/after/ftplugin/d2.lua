--
-- Safe to run twice
--
vim.bo.commentstring = "# %s"

pcall(vim.keymap.del, "n", "<Leader>d2", { buffer = 0 })

--
-- Guard
--
if vim.b.did_ftplugin_d2 then
    return
end
vim.b.did_ftplugin_d2 = true
