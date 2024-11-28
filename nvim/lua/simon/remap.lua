vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.NERDTreeToggle) -- Open NERDTree
vim.keymap.set("n", "<leader>nf", vim.cmd.NERDTreeFind)   -- Open NERDTree with current file selected
-- Når man er i visual mode, kan man trykke stort K eller J for at flytte markerede tekst
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Appender linjen nednunder til den nuværende linje.
vim.keymap.set("n", "J", "mzJ`z")
-- Ctrl-d eller u for at gå en halv side op og ned af gangen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
--
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
  require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
  require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever. Hvis man markerer noget med yank
-- Så kan kan man derefter markere et ord og lave leader p
-- for at erstatte det ny markede ord med det yankede ord
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- Copies everything selected to the clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])          -- Copies the whole line to the clipboard

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- Delete without yanking

-- Rebind escape til at være tab som er rebinded til F13
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("v", "<F13>", "<Esc>")
vim.keymap.set("x", "<F13>", "<Esc>")
vim.keymap.set("i", "<F13>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Stå på et ord og rediger alle tilfælde af det ord i filen
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })              -- Gør filen executable

-- vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end) -- Reload neovim config

-- Formater kode
vim.keymap.set("n", "<leader>p", "mzgg=G`z", { noremap = true, silent = true })                       -- Ny formaterings keymap
vim.keymap.set('t', '<C-Space>', [[<C-\><C-n>]], { noremap = true })                                  -- Går ud af terminal når man er i terminal mode

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { noremap = true, silent = true }) -- Gå til definition, f.eks. tryk gd når cursor er på et React komponent, for at gå til det komponent

-- Split windows
vim.keymap.set('n', '<leader>h', '<Cmd>vsplit<CR><C-w>l', { noremap = true, silent = true }) -- Split window to the right and move focus to the new window
vim.keymap.set('n', '<leader>v', '<Cmd>split<CR><C-w>j', { noremap = true, silent = true })  -- Split window downwards and move focus to the new window
-- Resize windows
vim.keymap.set("n", "<Left>", ":vertical resize +4<CR>")
vim.keymap.set("n", "<Right>", ":vertical resize -4<CR>")
vim.keymap.set("n", "<Up>", ":horizontal resize -4<CR>")
vim.keymap.set("n", "<Down>", ":horizontal resize +4<CR>")


-- Vim tmux navigator
vim.keymap.set('n', '{Left-Mapping}', '<Cmd>TmuxNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '{Down-Mapping}', '<Cmd>TmuxNavigateDown<CR>', { silent = true })
vim.keymap.set('n', '{Up-Mapping}', '<Cmd>TmuxNavigateUp<CR>', { silent = true })
vim.keymap.set('n', '{Right-Mapping}', '<Cmd>TmuxNavigateRight<CR>', { silent = true })
vim.keymap.set('n', '{Previous-Mapping}', '<Cmd>TmuxNavigatePrevious<CR>', { silent = true })


-- JSX comments
vim.keymap.set("v", "<leader>x", function()
    -- Yank the visually selected text to update the '< and '> marks
    vim.cmd('normal! y')

    local s_start, s_end = vim.fn.getpos("'<"), vim.fn.getpos("'>")
    local start_line, start_col, end_line, end_col = s_start[2], s_start[3] - 1, s_end[2], s_end[3] - 1

    -- Adjust start_col and end_col for 0-indexing
    start_col = math.max(start_col, 0)

    -- Adjust end_col for the end of the line if it's set to the maximum value
    if end_col == 2^31-1 then
        end_col = vim.fn.col("'>") - 1
    end

    -- Get the text of the last line of the selection
    local line_text = vim.api.nvim_buf_get_lines(0, end_line - 1, end_line, false)[1]

    -- Adjust end_col to be at the end of the line if needed
    if end_col > #line_text then
        end_col = #line_text
    elseif end_col == 0 then
        end_col = #line_text
    end

    -- Insert the comments
    vim.api.nvim_buf_set_text(0, end_line - 1, end_col, end_line - 1, end_col, {" */}"})
    vim.api.nvim_buf_set_text(0, start_line - 1, start_col, start_line - 1, start_col, {"{/* "})

    -- Restore the visual selection
    vim.cmd('normal! gv')
end, {silent = true})



