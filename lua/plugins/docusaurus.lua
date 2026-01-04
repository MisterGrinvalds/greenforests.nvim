-- docusaurus.nvim - Streamlines Docusaurus documentation editing
-- https://github.com/Piotr1215/docusaurus.nvim
local fork = require('lib.forks').fork

return {
  fork('Piotr1215/docusaurus.nvim'),
  branch = 'build-tools',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  lazy = false,
  config = function()
    require('docusaurus').setup {}

    vim.keymap.set('n', '<leader>Dc', '<cmd>DocusaurusInsertComponent<cr>', { desc = '[D]ocusaurus insert [C]omponent' })
    vim.keymap.set('n', '<leader>Dp', '<cmd>DocusaurusInsertPartial<cr>', { desc = '[D]ocusaurus insert [P]artial' })
    vim.keymap.set('n', '<leader>Db', '<cmd>DocusaurusInsertCodeBlock<cr>', { desc = '[D]ocusaurus insert code [B]lock' })
    vim.keymap.set('n', '<leader>Du', '<cmd>DocusaurusInsertURL<cr>', { desc = '[D]ocusaurus insert [U]RL' })
    vim.keymap.set('n', '<leader>Dn', '<cmd>DocusaurusCreatePlugin<cr>', { desc = '[D]ocusaurus [N]ew plugin' })
    vim.keymap.set('n', '<leader>Da', '<cmd>DocusaurusBrowseAPI<cr>', { desc = '[D]ocusaurus browse [A]PI' })
  end,
}
