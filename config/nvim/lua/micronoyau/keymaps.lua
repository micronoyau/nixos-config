local s = vim.keymap.set

s("n", "<C-l>", "<c-w>l")
s("n", "<C-h>", "<c-w>h")
s("n", "<C-j>", "<c-w>j")
s("n", "<C-k>", "<c-w>k")

s("n", "<leader>ee", ":Neotree toggle<cr>")
s("n", "<leader>ef", ":Neotree focus<cr>")

s("n", "<leader>bf", ":Telescope buffers<cr>")
s("n", "<leader>ff", ":Telescope live_grep<cr>")

s("n", "<leader><tab>", ":bnext<cr>")
s("n", "<leader><S-tab>", ":bprev<cr>")

s("n", "<leader>+", ":resize +10<cr>")
s("n", "<leader>-", ":resize -10<cr>")
s("n", "<leader>>", ":vertical resize +10<cr>")
s("n", "<leader><", ":vertical resize -10<cr>")
s("n", "<leader>=", "<c-w>=")

s("n", "<leader>s", ":vs<cr>")
s("n", "<leader>S", ":sp<cr>")
s("n", "<leader>fs", ":tab split<cr>")

s("n", "<leader>y", "\"+y")
s("v", "<leader>y", "\"+y")
s("n", "<leader>p", "\"+p")

s("n", "<leader>t2", ":set shiftwidth=2<cr>:set tabstop=2<cr>")
s("n", "<leader>t4", ":set shiftwidth=4<cr>:set tabstop=4<cr>")

s("n", "<leader>tt", ":ToggleTerm direction=float<cr>")
s("t", "<Esc>", "<c-\\><c-n>")

s("n", "<leader>hd", ":HexDump<cr>")
s("n", "<leader>ha", ":HexAssemble<cr>")

