return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup()

    -- Keymaps
    local map = vim.keymap.set

    -- Navigate buffers
    map('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
    map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' })

    -- Reorder buffers
    map('n', '<leader>bn', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move buffer right' })
    map('n', '<leader>bp', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move buffer left' })

    -- Pick a buffer by letter
    map('n', '<leader>bb', '<cmd>BufferLinePick<cr>', { desc = 'Pick buffer' })

    -- Close buffer
    map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })

    -- Go to a specific number (1 to 9)
    for i = 1, 9 do
      map('n', '<leader>' .. i, function()
        require('bufferline').go_to(i)
      end, { desc = 'Go to buffer ' .. i })
    end
  end,
}
