defmodule Diex.DispatcherBuilder do
  @moduledoc """
  Defines the macros that build the dynamic dispatchers.
  """

  defmacro build(fn_name, arity, adapter) do
    args = Diex.ArgumentExpander.create_args(__MODULE__, arity)

    quote do
      # We can specify documentation for the function
      @doc "Dynamic dispatcher, for the callback with the same name."
      def unquote(fn_name)(unquote_splicing(args), adapter \\ unquote(adapter)) do
        adapter.unquote(fn_name)(unquote_splicing(args))
      end
    end
  end
end
