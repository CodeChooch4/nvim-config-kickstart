return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local parsers = {
        'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline',
        'query', 'vim', 'vimdoc',
        'css', 'scss', 'javascript', 'typescript', 'tsx', 'json',
        'vue', 'svelte', 'astro',
        'yaml', 'toml', 'dockerfile', 'gitignore',
        'prisma',
      }

      require('nvim-treesitter').install(parsers)

      -- Use the tsx parser for JSX buffers too.
      vim.treesitter.language.register('tsx', { 'javascriptreact' })

      -- jsonc parser was removed from nvim-treesitter main; reuse json.
      vim.treesitter.language.register('json', { 'jsonc' })

      local filetypes = {
        'bash', 'sh', 'zsh',
        'c',
        'diff',
        'html',
        'lua',
        'markdown',
        'query',
        'vim', 'help',
        'css', 'scss',
        'javascript', 'typescript', 'typescriptreact', 'javascriptreact',
        'json', 'jsonc',
        'vue', 'svelte', 'astro',
        'yaml', 'toml',
        'dockerfile', 'gitignore',
        'prisma',
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
