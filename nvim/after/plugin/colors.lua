-- require('rose-pine').setup({
  --     disable_background = true
  -- })

  vim.cmd("colorscheme tokyonight-moon ")  -- Corrected command to set colorscheme



  function HiLine ()
    vim.cmd([[hi LineNr guibg=none guifg=#ffffff]])
  end


