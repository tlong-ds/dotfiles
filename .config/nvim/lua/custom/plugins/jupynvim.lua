return {
  'sheng-tse/jupynvim',
  lazy = false,
  cmd = {
    'JupynvimOpen',
    'JupynvimRunCell',
    'JupynvimRunAll',
    'JupynvimKernel',
    'JupynvimRestart',
    'JupynvimClearOutputs',
    'JupynvimClearCellOutput',
    'JupynvimSaveImage',
    'JupynvimDeleteImage',
    'JupynvimImageMode',
    'JupynvimReset',
    'JupynvimDebug',
  },
  build = function(plugin)
    local install = assert(loadfile(plugin.dir .. '/lua/jupynvim/install.lua'))()
    install.run(plugin)
  end,
  config = function()
    require('jupynvim').setup {
      log_level = 'info',
      image_renderer = 'kitty',
    }
  end,
}
