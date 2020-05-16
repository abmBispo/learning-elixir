defmodule ChangeProblemTest do
  use ExUnit.Case
  doctest ChangeProblem

  test "List [10, 30, 20, 5, 25, 15] to change 50 should return [25, 25]" do
    assert ChangeProblem.solve(50, [10, 30, 20, 5, 25, 15]) == [25, 25]
  end
end
