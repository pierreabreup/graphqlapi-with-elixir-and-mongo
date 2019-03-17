defmodule LrmiGraphql.Schema do
  use Absinthe.Schema

  import_types LrmiGraphql.Schema.ObjectTypes.CreativeWork


  query do
    import_fields :creative_work_queries
  end
end
