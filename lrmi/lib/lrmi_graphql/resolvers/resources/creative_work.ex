defmodule LrmiGraphql.Resolvers.Resources.CreativeWork do
  alias Lrmi.Resources
  alias Absinthe.Relay
  alias LrmiGraphql.Helpers.Absinthe.DataPaginator

  def paged_list(args) do
    pagination_args = DataPaginator.build_args(args)
    contents = Resources.list_creative_works(pagination_args)
    {contents, page_info} = DataPaginator.page_info(contents, pagination_args)

    Relay.Connection.from_slice(contents, pagination_args.offset, page_info)
  end


end
