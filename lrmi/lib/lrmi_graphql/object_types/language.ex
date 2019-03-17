defmodule LrmiGraphql.Schema.ObjectTypes.Language do
  use Absinthe.Schema.Notation

  object :language do
    field :typeOf, non_null(:string)
    field :name, non_null(:string)
    field :alternateName, non_null(:string)
  end
end
