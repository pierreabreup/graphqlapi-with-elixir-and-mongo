defmodule LrmiGraphql.Schema.ObjectTypes.CreativeWork do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema, :modern

  import_types Absinthe.Type.Custom
  import_types LrmiGraphql.Schema.ObjectTypes.{
    Person,
    Language,
    Publisher
  }

  alias LrmiGraphql.Resolvers


  object :creative_work do
    field :type_of, non_null(:string)
    field :name, non_null(:string)
    field :date_created, non_null(:datetime)
    field :date_modified, non_null(:datetime)
    field :learning_resource_type, non_null(:string)
    field :position, :integer
    field :description, :string
    field :educational_use, :string
    field :interactivity_type, :string
    field :url, :string
    field :author, list_of(:person)
    field :additional_property, list_of(:property_value)
    field :educational_alignment, list_of(:alignment_object)
    field :identifier, non_null(:property_value)
    field :publisher, :publisher
    field :in_language, :language
  end

  object :property_value do
    field :type_of, non_null(:string)
    field :property_id,  non_null(:string)
    field :value, non_null(:string)
  end

  object :alignment_object do
    field :type_of, non_null(:string)
    field :alignment_type, non_null(:string)
    field :educational_framework, non_null(:string)
    field :target_name, non_null(:string)
    field :target_url, :string
  end

  input_object :identifier_input do
    field :property_id, non_null(:string)
    field :value, non_null(:string)
  end

  connection node_type: :creative_work

  object :creative_work_queries do
    connection field :creative_works, node_type: :creative_work do
      arg :type_of, :string
      arg :identifier, :identifier_input

      resolve fn
        args, _ ->
          pagination_limit = Application.get_env(:lrmi, :data_pagination)[:limit]
          cond do
            Map.fetch(args, :first) == :error && Map.fetch(args, :last) == :error ->
              {:error, "The argument \"first\" or the argument \"last\" must be present"}
            Map.get(args, :first, 0) > pagination_limit || Map.get(args, :last, 0) > pagination_limit ->
              {:error, "The first/last argument must be lower or equal than #{pagination_limit}" }
            true ->
              Resolvers.Resources.CreativeWork.paged_list(args)
          end

      end

      middleware &replace_relay_connection_cursors/2
    end
  end

  defp replace_relay_connection_cursors(resolution, _) do
    case resolution.value do
      nil ->
        resolution
      _ ->
        new_edges = edges_cursors_to_object_id(resolution.value.edges)
        page_info = page_info_cursors_to_object_id(new_edges, resolution.value.page_info)

        resolution_value =
          resolution.value
          |> Map.replace!(:edges, new_edges)
          |> Map.replace!(:page_info, page_info)


        %{resolution | value: resolution_value}
    end
  end

  defp edges_cursors_to_object_id(edges) do
    Enum.map(
      edges,
      fn edge -> %{edge | cursor: BSON.ObjectId.encode!(edge.node._id)} end
    )
  end

  defp page_info_cursors_to_object_id(edges, page_info) when length(edges) == 0 do
    page_info
  end

  defp page_info_cursors_to_object_id(edges, page_info) do
    page_info
    |> Map.replace!(:start_cursor, Enum.at(edges, 0).cursor)
    |> Map.replace!(:end_cursor, Enum.at(edges, -1).cursor)
  end


end
