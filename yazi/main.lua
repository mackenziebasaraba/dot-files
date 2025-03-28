require("zoxide"):setup({
    update_db = true,
})

require("session"):setup({
    sync_yanked = true,
})

require("no-status"):setup()
