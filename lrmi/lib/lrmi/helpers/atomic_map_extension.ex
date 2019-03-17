defmodule AtomicMap.Extension do
  import String, only: [first: 1, replace: 4, downcase: 1, upcase: 1]

  def keys_to_camel_case(value) when is_map(value) == false do
    value
  end

  def keys_to_camel_case(map) when is_map(map) do
    try do
      for {key, val} <- map,
        into: %{},
        do: {camel_case(key), keys_to_camel_case(val)}
    rescue
      Protocol.UndefinedError -> map
    end
  end

  defp camel_case(key) when is_atom(key) do
    key = Atom.to_string(key)
    first_char = key |> first

    key
    |> Macro.camelize
    |> replace(upcase(first_char), downcase(first_char), global: false)
  end

end
