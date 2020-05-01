# With tail-call optmization
defmodule SortOptmized do
  def selection(enumerable) do
    selection(enumerable, [])
  end

  defp selection([], tco_acc), do: tco_acc
  defp selection(enumerable, tco_acc) do
    max_value = max(enumerable)
    List.delete(enumerable, max_value) |> selection([max_value | tco_acc])
  end

  defp max([]), do: []
  defp max([first | tail]) do
    greater(first, max(tail))
  end

  defp greater(n1, n2) when is_list(n2), do: n1
  defp greater(n1, n2) do
    if n1 > n2 do n1 else n2 end
  end
end

defmodule Sort do
  def selection([]), do: []
  def selection(enumerable) do
    min_value = min(enumerable)
    [min_value | List.delete(enumerable, min_value) |> selection()]
  end

  def min([]), do: []
  def min([first | tail]) do
    smaller(first, min(tail))
  end

  def smaller(n1, n2) do
    if n1 <= n2 do n1 else n2 end
  end
end

defmodule Time do
  def now, do: ({msecs, secs, musecs} = :erlang.now; ((msecs*1000000 + secs)*1000000 + musecs)/1000000)
end

random_list = (1..60000) |> Enum.map(fn _ -> :rand.uniform(1000) end)

IO.puts "Memory: #{:erlang.memory(:total)/(1024*1024)}"

t = Time.now
list3 = SortOptmized.selection(random_list)
appending_optimized_selection_sort = Time.now - t

IO.puts "Memory: #{:erlang.memory(:total)/(1024*1024)}"

t = Time.now
list2 = Sort.selection(random_list)
appending_selection_sort = Time.now - t

IO.puts "Memory: #{:erlang.memory(:total)/(1024*1024)}"

IO.puts "Running Elixir selection sort with appending takes #{appending_selection_sort} seconds"
IO.puts "Running Elixir selection sort with appending (optimized) takes #{appending_optimized_selection_sort} seconds"
IO.puts "Match? Answer: #{list2 == list3}"
