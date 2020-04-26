defmodule Sort do
  def selection([]), do: []

  def selection(enumerable) do
    min_value = Enum.reduce(enumerable, fn(n, callback) ->
      if n < callback do
        n
      else
        callback
      end
    end)

    [min_value | List.delete(enumerable, min_value) |> selection()]
  end
end

list = Sort.selection([4, 3, 5, 2, 1])
IO.inspect list, label: "The ordered list is"
