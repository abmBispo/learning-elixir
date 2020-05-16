defmodule ChangeProblemOptimizedTest do
  use ExUnit.Case
  doctest ChangeProblem

  test "List [10, 30, 20, 5, 25, 15] to change 50 should return [25, 25]" do
    assert ChangeProblemOptimized.solve(50, [10, 30, 20]) == [20, 30]
  end
end
