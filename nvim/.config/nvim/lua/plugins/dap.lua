vim.keymap.set("n", "<Leader>r", ":lua require'dap'.run_last()<CR>")
vim.keymap.set("n", "<F5>", ":lua require'jdtls'.test_class()<CR>")
vim.keymap.set("n", "<Leader>t", ":lua require'jdtls'.test_nearest_method()<CR>")
