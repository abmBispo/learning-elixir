defmodule ChangeProblem do
  def solve(value_to_change, availabel_coins) do
    solve(value_to_change, availabel_coins, [], 0)
  end

  defp solve(value_to_change, _, _, _) when value_to_change < 0, do: []
  defp solve(_, availabel_coins, _, idx) when idx == length(availabel_coins), do: []
  defp solve(value_to_change, _, selected_coins, _) when value_to_change == 0, do: selected_coins
  defp solve(value_to_change, availabel_coins, selected_coins, idx) do
    # TODO: memorize
    {coin, _} = List.pop_at(availabel_coins, idx)
    IO.puts "**************************"
    IO.puts "coin: #{coin}"
    res1 = solve(value_to_change - coin, availabel_coins, [coin | selected_coins], idx)
    res2 = solve(value_to_change - coin, availabel_coins, [coin | selected_coins], idx + 1)

    res = cond do
      length(res1) > 0 && length(res2) > 0 ->
        cond do
          length(res2) >= length(res1) -> res1
          length(res1) >= length(res2) -> res2
        end
      length(res1) == 0 -> res2
      length(res2) == 0 -> res1
      true -> []
    end

    res1 |> IO.inspect(label: "Res1", charlists: :as_lists)
    res2 |> IO.inspect(label: "Res2", charlists: :as_lists)
    res |> IO.inspect(label: "Res", charlists: :as_lists)

    res
  end
end

value_to_change = 50
availabel_coins = [30, 10, 20]

answer = ChangeProblem.solve(value_to_change, availabel_coins)
answer |> IO.inspect(label: "Answer", charlists: :as_lists)
