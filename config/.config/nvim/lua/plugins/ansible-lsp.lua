return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {
          settings = {
            ansible = {
              ansible = {
                path = "ansible",
                useFullyQualifiedCollectionNames = true,
              },
              ansibleLint = {
                enabled = true,
                path = "ansible-lint",
              },
              executionEnvironment = {
                enabled = false,
              },
              python = {
                interpreterPath = "python",
              },
              completion = {
                provideRedirectModules = true,
                provideModuleOptionAliases = true,
              },
            },
          },
        },
      },
    },
  },
}
