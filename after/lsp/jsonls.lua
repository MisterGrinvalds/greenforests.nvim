-- jsonls (JSON) language server configuration with SchemaStore
return {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
