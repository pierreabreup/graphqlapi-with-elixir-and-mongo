defmodule Lrmi.ResourcesTest do
  use Lrmi.DataCase

  alias Lrmi.Resources

  describe "Resources" do

    def create_creative_work(attrs \\ %{}) do
      build(:creative_work, attrs)
      |> Resources.create_creative_work()
    end

    test "list_creative_works/1 with no args returns any content" do
      {_, content} = create_creative_work()

      assert Resources.list_creative_works(%{}) == [content]
    end

    test "list_creative_works/1 with 'typeOf' argument returns contents for specific typeOf" do
      attrs = %{typeOf: "chapter"}
      create_creative_work()
      {_, content} = create_creative_work(attrs)

      assert Resources.list_creative_works(attrs) == [content]
    end

    test "list_creative_works/1 with 'after' argument returns next content" do
      {_, content_one} = create_creative_work()
      {_, content_two} = create_creative_work()

      assert Resources.list_creative_works(%{after: BSON.ObjectId.encode!(content_one._id)}) == [content_two]
    end

    test "list_creative_works/1 with 'before' argument returns previous content" do
      {_, content_one} = create_creative_work()
      {_, content_two} = create_creative_work()

      assert Resources.list_creative_works(%{before: BSON.ObjectId.encode!(content_two._id)}) == [content_one]
    end

    test "create_creative_work/1 with valid data creates a content" do
      assert {:ok, %{} = content} = create_creative_work()
    end


    test "create_creative_work/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_creative_work(%{})
    end

  end
end
