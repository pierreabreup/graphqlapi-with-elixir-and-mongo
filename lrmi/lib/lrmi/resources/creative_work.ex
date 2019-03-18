defmodule Lrmi.Resources.CreativeWork do
  use Ecto.Schema
  import Ecto.Changeset
  alias Lrmi.Resources.CreativeWork


  schema "creative_works" do
    field :url,                  :string
    field :typeOf,               :string
    field :name,                 :string
    field :description,          :string
    field :educationalUse,       :string
    field :interactivityType,    :string
    field :learningResourceType, :string
    field :position,             :integer
    field :dateCreated,          :utc_datetime
    field :dateModified,         :utc_datetime
    field :identifier,           :map
    field :publisher,            :map
    field :inLanguage,           :map
    field :author,               {:array, :map}
    field :additionalProperty,   {:array, :map}
    field :educationalAlignment, {:array, :map}
  end

  def changeset(%CreativeWork{} = content, attrs) do
      content
      |> cast(attrs, [
        :url,
        :name,
        :typeOf,
        :author,
        :position,
        :publisher,
        :inLanguage,
        :identifier,
        :description,
        :dateCreated,
        :dateModified,
        :educationalUse,
        :interactivityType,
        :additionalProperty,
        :educationalAlignment,
        :learningResourceType
        ])
      |> validate_required([:typeOf, :name, :dateCreated, :dateModified, :identifier])
  end
end
