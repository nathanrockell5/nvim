-- ~/.config/nvim/lua/plugins/folding.lua
-- "I just want folding that works and I can click" – the plugin

return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    -- optional: keep your old zM/zR if you want
    {
      'zR',
      function()
        require('ufo').openAllFolds()
      end,
      desc = 'Open all folds',
    },
    {
      'zM',
      function()
        require('ufo').closeAllFolds()
      end,
      desc = 'Close all folds',
    },
  },
  config = function()
    vim.o.foldcolumn = '1' -- shows the nice fold gutter
    vim.o.foldlevel = 99 -- everything open by default
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    require('ufo').setup {
      provider_selector = function()
        return { 'treesitter', 'indent' } -- treesitter first, then indent fallback
      end,
      -- optional: prettier fold text
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ('  %d lines'):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end,
    }

    -- Make clicking actually work (works in every modern terminal + GUI)
    vim.keymap.set('n', '<LeftRelease>', '<LeftRelease>zA', { remap = true, silent = true })
  end,
}
