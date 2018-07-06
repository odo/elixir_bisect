defmodule BisectTest do
  use ExUnit.Case
  doctest Bisect

  @backend Bisect.List
  @double_list (1..100) |> Enum.into([]) |> Enum.map(& &1 * 2)

  test "find" do
    assert {0, 2} == Bisect.find(2, @backend, @double_list)
    assert {99, 200} == Bisect.find(200, @backend, @double_list)
    assert {41, 84} == Bisect.find(84, @backend, @double_list)
  end

  test "find off limts" do
    assert {0, 2} == Bisect.find(-10, @backend, @double_list)
    assert {99, 200} == Bisect.find(1000, @backend, @double_list)
  end

  test "find in between" do
    assert {42, 86} == Bisect.find(85, @backend, @double_list)
  end

  test "find rightmost with repeats" do
    # index[0, 1, 2, 3, 4, 5, 6, 7, 8]
    list = [1, 1, 1, 2, 2, 2, 3, 3, 3]
    assert {0, 1} == Bisect.find(0, @backend, list)
    assert {2, 1} == Bisect.find(1, @backend, list)
    assert {5, 2} == Bisect.find(2, @backend, list)
    assert {8, 3} == Bisect.find(3, @backend, list)
    assert {8, 3} == Bisect.find(4, @backend, list)
  end

end
