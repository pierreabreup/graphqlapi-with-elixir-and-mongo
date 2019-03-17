defmodule LrmiGraphql.Helpers.Absinthe.DataPaginator do

  def build_args(pagination_args) do
    pagination_args
    |> Map.put(:limit, limit(pagination_args) + 1) #increase 1 to detect if there is a next_page
    |> Map.put(:sort, sort(pagination_args))
    |> Map.put(:offset, offset())
  end

  def page_info(data_list, pagination_args) do
    limit  = (pagination_args.limit - 1) #discount increased limit
    {
      Enum.take(data_list, limit),
      [
        has_next_page: length(data_list) > limit,
        has_previous_page: Map.has_key?(pagination_args, :after) #THIS  HAVE TO BE FIXED
      ]
    }
  end

  defp limit(pagination_args) do
    Map.get(pagination_args, :first, Map.get(pagination_args, :last))
  end

  defp sort(pagination_args) do
    %{_id: Map.has_key?(pagination_args, :last) && - 1 || 1 }
  end

  defp offset() do
    0 #FORCE TO 0 BECAUSE PAGINATION IS DONE BY CURSOR (object ID)
  end
end
