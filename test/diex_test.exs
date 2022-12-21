defmodule DiexTest do
  use ExUnit.Case

  doctest Diex

  defmodule Behaviour do
    use Diex, adapter: DiexTest.Adapter

    @callback my_callback() :: :ok
    @callback my_callback2(param1 :: term) :: {:ok, term} | {:error, term}
    @callback my_callback3(param1 :: term, param2 :: term) :: {:ok, {term, term}}
  end

  defmodule Adapter do
    @behaviour DiexTest.Behaviour

    @impl true
    @spec my_callback :: :ok
    def my_callback(), do: :ok

    @impl true
    @spec my_callback2(any) :: {:ok, any}
    def my_callback2(arg), do: {:ok, arg}

    @impl true
    @spec my_callback3(any, any) :: {:ok, {any, any}}
    def my_callback3(arg, arg2), do: {:ok, {arg, arg2}}
  end


  test "tries to use the dynamic dispatcher for my_callback/0" do
    assert Behaviour.my_callback() == :ok
  end

  test "tries to use the dynamic dispatcher for my_callback2/1" do
    assert Behaviour.my_callback2(:some_value) == {:ok, :some_value}
  end

  test "tries to use the dynamic dispatcher for my_callback3/1" do
    assert Behaviour.my_callback3(:some_value, :and_another) == {:ok, {:some_value, :and_another}}
  end
end
