defmodule Lrmi.Resources.CreativeWorkTest do
  use Lrmi.DataCase
  alias Lrmi.Resources.CreativeWork

  describe "Resources.CreativeWork" do
    test "typeOf is required" do
      changeset = CreativeWork.changeset(%CreativeWork{}, %{})
      assert %{typeOf: ["can't be blank"]} = errors_on(changeset)
    end

    test "name is required" do
      changeset = CreativeWork.changeset(%CreativeWork{}, %{})
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "dateCreated is required" do
      changeset = CreativeWork.changeset(%CreativeWork{}, %{})
      assert %{dateCreated: ["can't be blank"]} = errors_on(changeset)
    end

    test "dateModified is required" do
      changeset = CreativeWork.changeset(%CreativeWork{}, %{})
      assert %{dateModified: ["can't be blank"]} = errors_on(changeset)
    end

    test "identifier is required" do
      changeset = CreativeWork.changeset(%CreativeWork{}, %{})
      assert %{identifier: ["can't be blank"]} = errors_on(changeset)
    end

    test "dateCreated must be ISO 8601 DateTime UTC" do
      content = build(:creative_work)
      |> Map.replace!(:dateCreated, "2019-01-23T18:00:38Z")

      changeset = CreativeWork.changeset(%CreativeWork{}, content)
      assert changeset.valid?
    end

    test "dateModified must be ISO 8601 DateTime UTC" do
      content = build(:creative_work)
      |> Map.replace!(:dateModified, "2019-01-23T18:00:38Z")

      changeset = CreativeWork.changeset(%CreativeWork{}, content)
      assert changeset.valid?
    end
  end
end
