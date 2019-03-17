alias Lrmi.Resources

seed_data = Application.app_dir(:lrmi, ["priv","seed_data","creative_work.json"])
    |> File.read!()
    |> Jason.decode!()

Enum.each seed_data, fn(content) ->
  case Resources.create_creative_work(content) do
    {:ok, saved_content} ->
      Mix.shell.info("DOCUMENT #{saved_content.name} INSERTED")
    {:error, error} ->
      Mix.shell.info("ERRROR ON #{content["name"]}")
      IO.inspect(error)
  end
end

Mix.shell.info("FINISH!")
