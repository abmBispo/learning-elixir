defmodule ChangeProblem do
  def solve(value_to_change, available_coins) do
    solve(value_to_change, available_coins, [])
  end

  defp solve(value_to_change, _, _) when value_to_change < 0, do: []
  defp solve(value_to_change, _, choosen_coins) when value_to_change == 0, do: choosen_coins
  defp solve(_, [], _), do: []
  defp solve(value_to_change, [coin | remaining_coins], choosen_coins) do
    first_branch = solve(value_to_change - coin, [coin | remaining_coins], [coin | choosen_coins])
    second_branch = solve(value_to_change, remaining_coins, choosen_coins)
    IO.puts "***********"
    first_branch |> IO.inspect(label: "first_branch", charlists: :as_lists)
    second_branch |> IO.inspect(label: "second_branch", charlists: :as_lists)
    solution = cond do
      length(first_branch) == 0 && length(second_branch) > 0 -> second_branch
      length(second_branch) == 0 && length(first_branch) > 0 -> first_branch
      length(second_branch) > length(first_branch) -> first_branch
      length(first_branch) > length(second_branch) -> second_branch
      length(first_branch) == length(second_branch) -> second_branch
      true -> []
    end
    solution |> IO.inspect(label: "solution")
    solution
  end
end

value_to_change = 50
availabel_coins = [20]

answer = ChangeProblem.solve(value_to_change, availabel_coins)
answer |> IO.inspect(label: "Answer", charlists: :as_lists)
