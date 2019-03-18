defmodule LrmiGraphql.Schema.ObjectTypes.ContentTest do
  use ExUnit.Case

  alias LrmiGraphql.Schema.ObjectTypes.CreativeWork

  describe "Schema.ObjectTypes.CreativeWork" do
    test " __absinthe_types__ are valids" do

      types = %{
        alignment_object: "AlignmentObject",
        creative_work: "CreativeWork",
        creative_work_connection: "CreativeWorkConnection",
        creative_work_edge: "CreativeWorkEdge",
        creative_work_queries: "CreativeWorkQueries",
        date: "Date",
        datetime: "DateTime",
        decimal: "Decimal",
        identifier_input: "IdentifierInput",
        language: "Language",
        naive_datetime: "NaiveDateTime",
        page_info: "PageInfo",
        person: "Person",
        property_value: "PropertyValue",
        publisher: "Publisher",
        time: "Time"
      }

      assert types == CreativeWork.__absinthe_types__()
    end

    test "creative work structure is valid" do
      types = [
        additional_property: %Absinthe.Type.List{of_type: :property_value},
        author: %Absinthe.Type.List{of_type: :person},
        date_created: %Absinthe.Type.NonNull{of_type: :datetime},
        date_modified: %Absinthe.Type.NonNull{of_type: :datetime},
        description: :string,
        educational_alignment: %Absinthe.Type.List{of_type: :alignment_object},
        educational_use: :string,
        identifier: %Absinthe.Type.NonNull{of_type: :property_value},
        in_language: :language,
        interactivity_type: :string,
        learning_resource_type: %Absinthe.Type.NonNull{of_type: :string},
        name: %Absinthe.Type.NonNull{of_type: :string},
        position: :integer,
        publisher: :publisher,
        type_of: %Absinthe.Type.NonNull{of_type: :string},
        url: :string
      ]


      assert types == Enum.map(CreativeWork.__absinthe_type__(:creative_work).fields, fn {k, v} -> {k, v.type} end)
    end

    test "alignment_object structure is valid" do
      types = [
        alignment_type: %Absinthe.Type.NonNull{of_type: :string},
        educational_framework: %Absinthe.Type.NonNull{of_type: :string},
        target_name: %Absinthe.Type.NonNull{of_type: :string},
        target_url: :string,
        type_of: %Absinthe.Type.NonNull{of_type: :string}
      ]

      assert types == Enum.map(CreativeWork.__absinthe_type__(:alignment_object).fields, fn {k, v} -> {k, v.type} end)
    end

  end
end
