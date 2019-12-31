defmodule DiexTest do
  use ExUnit.Case
  doctest Diex

  test "greets the world" do
    assert Diex.hello() == :world
  end
end
