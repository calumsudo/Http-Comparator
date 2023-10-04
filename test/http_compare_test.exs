defmodule HttpCompareTest do
  use ExUnit.Case
  doctest HttpCompare

  test "greets the world" do
    assert HttpCompare.hello() == :world
  end
end
