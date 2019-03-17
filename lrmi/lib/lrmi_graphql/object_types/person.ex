defmodule LrmiGraphql.Schema.ObjectTypes.Person do
  use Absinthe.Schema.Notation

  object :person do
    field :type_of, non_null(:string)
    field :name, non_null(:string)
    field :url, :string
  end
end
