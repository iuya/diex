defmodule Diex do
  @moduledoc """
  Documentation for Diex.
  """

  @doc ~S"""
  Hello world.

  ## Examples

      iex> Diex.hello()
      :world

  """
  @type ast_exp :: {atom(), options, [any]}

  @type option :: {:name, String.t()} | {:max, pos_integer} | {:min, pos_integer}
  @type options :: [option]

  # defmacro add_dispatcher(function_name: arity) do
  #   quote do
  #     def function_name()
  #   end
  # end

  def hello do
    :world
  end
end
