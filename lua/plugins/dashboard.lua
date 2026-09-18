return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        -- Set your custom ASCII logo string or table here
        header = [[

██████╗ ██████╗  █████╗ ██╗███████╗███████╗     █████╗ ██╗     ██╗      █████╗ ██╗  ██╗
██╔══██╗██╔══██╗██╔══██╗██║██╔════╝██╔════╝    ██╔══██╗██║     ██║     ██╔══██╗██║  ██║
██████╔╝██████╔╝███████║██║███████╗█████╗      ███████║██║     ██║     ███████║███████║
██╔═══╝ ██╔══██╗██╔══██║██║╚════██║██╔══╝      ██╔══██║██║     ██║     ██╔══██║██╔══██║
██║     ██║  ██║██║  ██║██║███████║███████╗    ██║  ██║███████╗███████╗██║  ██║██║  ██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝    ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝

🕌 Subhanallah 🕌 Alhamdulillah 🕌 La ilaha illa Allah 🕌]],
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
        { section = "startup" },
      },
    },
  },
}
