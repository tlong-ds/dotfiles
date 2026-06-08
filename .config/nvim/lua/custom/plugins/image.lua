local function detect_image_backend()
  local term_program = (vim.env.TERM_PROGRAM or ''):lower()
  local term = (vim.env.TERM or ''):lower()

  if term_program == 'ghostty' or term_program == 'kitty' or term_program == 'wezterm' then return 'kitty' end
  if term:find('kitty', 1, true) then return 'kitty' end
  if vim.fn.executable 'ueberzugpp' == 1 then return 'ueberzug' end

  return 'sixel'
end

return {
  '3rd/image.nvim',
  build = false,
  event = 'VeryLazy',
  keys = {
    {
      '<leader>ui',
      function()
        local image = require 'image'
        if image.is_enabled() then
          image.disable()
        else
          image.enable()
        end
      end,
      desc = 'Toggle images',
    },
  },
  opts = function()
    local in_tmux = vim.env.TMUX ~= nil and vim.env.TMUX ~= ''

    return {
      backend = detect_image_backend(),
      processor = 'magick_cli',
      editor_only_render_when_focused = true,
      tmux_show_only_in_active_window = in_tmux,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = true,
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { 'markdown' },
        },
      },
    }
  end,
  config = function(_, opts)
    require('image').setup(opts)
  end,
}
