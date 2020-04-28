defmodule Sort do
  def selection([]), do: []

  def selection(enumerable) do
    min_value = min(enumerable)
    [min_value | List.delete(enumerable, min_value) |> selection()]
  end

  def min([first | tail]) do
    smaller(first, min(tail))
  end

  def min([]), do: []

  def smaller(n1, n2) do
    if n1 <= n2 do n1 else n2 end
  end
end

defmodule Selection do
  def sort(list) when is_list(list) do
    do_selection(list, [])
  end

  def do_selection([head|[]], acc) do
    acc ++ [head]
  end
  def do_selection(list, acc) do
    min = min(list)
    do_selection(:lists.delete(min, list), acc ++ [min])
  end

  defp min([first|[second|[]]]) do
    smaller(first, second)
  end
  defp min([first|[second|tail]]) do
    min([smaller(first, second)|tail])
  end

  defp smaller(e1, e2) do
    if e1 <= e2 do e1 else e2 end
  end
end

defmodule Time do
  def now, do: ({msecs, secs, musecs} = :erlang.now; ((msecs*1000000 + secs)*1000000 + musecs)/1000000)
end

random_list = (1..20000) |> Enum.map(fn _ -> :rand.uniform(1000) end)

IO.puts "Memory: #{:erlang.memory(:total)}"

t = Time.now
Selection.sort(random_list)
prepending_selection_sort = Time.now - t

IO.puts "Memory: #{:erlang.memory(:total)}"

t = Time.now
Sort.selection(random_list)
appending_selection_sort = Time.now - t

IO.puts "Memory: #{:erlang.memory(:total)}"

IO.puts "Running Elixir selection sort with prepeding takes #{prepending_selection_sort} seconds"
IO.puts "Running Elixir selection sort with appending takes #{appending_selection_sort} seconds"
