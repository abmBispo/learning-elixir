defmodule ChangeProblemOptimized do
  def solve(value_to_change, available_coins) do
    memoization = Matrix.zeros(value_to_change + Enum.max(available_coins), Enum.max(available_coins) + 1)
    [memoization, result] = solve(value_to_change, available_coins, [], memoization)
    memoization |> Matrix.pretty_print("%d", " ")
    result
  end

  defp solve(value_to_change, _, [coin | choosen_coins], memoization) when value_to_change < 0, do: [Matrix.set(memoization, value_to_change, coin, 9), []]
  defp solve(value_to_change, _, [coin | choosen_coins], memoization) when value_to_change == 0 do
    # memoization |> Matrix.pretty_print("%d", " ")
    [Matrix.set(memoization, value_to_change, coin, 9), [coin | choosen_coins]]
  end
  defp solve(value_to_change, [], [coin | choosen_coins], memoization), do: [Matrix.set(memoization, value_to_change, coin, 9), []]
  defp solve(value_to_change, [coin | remaining_coins], choosen_coins, memoization) do

    IO.puts         "*******************************************"
    value_to_change |> IO.inspect(label: "value_to_change", charlists: :as_lists, limit: :infinity)
    coin            |> IO.inspect(label: "coin", charlists: :as_lists, limit: :infinity)
    remaining_coins |> IO.inspect(label: "remaining_coins", charlists: :as_lists, limit: :infinity)
    choosen_coins   |> IO.inspect(label: "choosen_coins", charlists: :as_lists, limit: :infinity)
    IO.puts "memoization[#{value_to_change}][#{coin}] = #{Matrix.elem(memoization, value_to_change, coin)}"
    Matrix.elem(memoization, value_to_change, coin) |> IO.inspect(label: "Matrix.elem")

    if Matrix.elem(memoization, value_to_change, coin) == 0 do
      # IO.puts "******************** == 0 ***********************"
      [memoization, first_branch] = solve(value_to_change - coin, [coin | remaining_coins], [coin | choosen_coins], Matrix.set(memoization, value_to_change, coin, 9))
      [_, second_branch] = solve(value_to_change, remaining_coins, choosen_coins, memoization)
      [memoization, cond do
        length(first_branch) == 0 && length(second_branch) > 0 -> second_branch
        length(second_branch) == 0 && length(first_branch) > 0 -> first_branch
        length(second_branch) > length(first_branch) -> first_branch
        length(first_branch) > length(second_branch) -> second_branch
        length(first_branch) == length(second_branch) -> second_branch
        true -> []
      end]
    else
      # IO.puts "******************** != 0 ***********************"
      [memoization, []]
    end
  end
end
