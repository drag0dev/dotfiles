local cmp = require("cmp")
local source_mapping = {
    nvim_lsp = "[LSP]",
    --cmp_tabnine = "[TN]",
    buffer = "[Buffer]",
}

cmp.setup({
    formatting = {
        format = function(entry, vim_item)
            local menu = source_mapping[entry.source.name]
            vim_item.menu = menu
            return vim_item
        end,
    },

    sources = {
        { name = "nvim_lsp" },
        --{ name = "cmp_tabnine" },
        { name = "buffer" },
    }
});

-- local tabnine = require("cmp_tabnine.config")
-- tabnine.setup({
--     max_lines = 1000,
--     max_num_results = 20,
--     sort = true,
--     run_on_every_keystroke = false,
--     snippet_placeholder = "..",
-- })

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable,
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer', keyword_length = 5 },
    }
    -- {
    --     { name = "cmp_tabnine"}
    -- }
    )
})

cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'cmp_git' },
}, {
  { name = 'buffer' },
})
})

cmp.setup.cmdline('/', {
sources = {
  { name = 'buffer' }
}
})

cmp.setup.cmdline(':', {
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

require('rust-tools').setup({}) -- extra stuff for rust
