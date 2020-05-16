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
    cond do
      length(first_branch) == 0 && length(second_branch) > 0 -> second_branch
      length(second_branch) == 0 && length(first_branch) > 0 -> first_branch
      length(second_branch) > length(first_branch) -> first_branch
      length(first_branch) > length(second_branch) -> second_branch
      length(first_branch) == length(second_branch) -> second_branch
      true -> []
    end
  end
end
