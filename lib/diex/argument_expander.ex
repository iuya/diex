defmodule Diex.ArgumentExpander do
  @moduledoc """
  Used to generate arguments for the dynamic dispatcher.
  Taken from: https://medium.com/elixirlabs/define-dynamic-functions-with-dynamic-arguments-arity-using-elixir-macros-a28241d4f119
  """

  @doc """
  Given a module name and argument count (arity), create the corresponding ast list.
      iex> Diex.ArgumentExpander.create_args(Diex, 0)
      []
      iex> Diex.ArgumentExpander.create_args(Diex, 2)
      [{:arg1, [], nil}, {:arg2, [], nil}]
  """
  @spec create_args(atom(), integer()) :: [Diex.ast_exp()]
  def create_args(_, 0), do: []

  def create_args(function_module, arg_count),
    do: Enum.map(1..arg_count, &Macro.var(:"arg#{&1}", function_module))
end
