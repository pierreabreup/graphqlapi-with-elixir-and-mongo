defmodule LrmiGraphql.Schema.ObjectTypes.Publisher do
  use Absinthe.Schema.Notation

  object :publisher do
    field :type_of, non_null(:string)
    field :name, non_null(:string)
  end
end
