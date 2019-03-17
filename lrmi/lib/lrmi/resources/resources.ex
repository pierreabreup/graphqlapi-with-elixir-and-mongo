defmodule Lrmi.Resources do

  alias Lrmi.Repo
  alias Lrmi.Resources.CreativeWork


  def list_creative_works(%{} = query) do
    Repo.all(CreativeWork, query)
  end

  def create_creative_work(attrs \\ %{}) do
    changeset = CreativeWork.changeset(%CreativeWork{}, attrs)
    case changeset.valid? do
      true ->
        Repo.insert(changeset)
      false ->
        {:error, changeset}
    end
  end

end
