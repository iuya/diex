defmodule Diex do
  @moduledoc ~S"""
  Diex introduces a single `use` macro that when used in a module with any callbacks
  and given an `adapter` module implementing them, generates it's dynamic dispatchers via
  defdelegate.

  ## Examples

  We need a callback module (where the dispatcher will be generated via `use Diex`) and a
  module implementing that behaviour

  Diex will allow us to call `Greetable.greet()` which will delegate in it's adapter's GreetingAdapter.greet()
      iex> defmodule GreetingAdapter do
      ...>   @behaviour Greetable
      ...>
      ...>   @impl Greetable
      ...>   def greet(), do: "Hello World!"
      ...> end
      iex> defmodule Greetable do
      ...> use Diex, adapter: GreetingAdapter
      ...>
      ...>   @callback greet() :: String.t()
      ...> end
      iex> Greetable.greet()
      "Hello World!"
  """

  @doc ~S"""
  Adds dynamic dispatchers to the callback module. Requires an adapter (a module implementing the behaviour) as argument.
  """
  @spec __using__([adapter: Macro.t()]) :: Macro.t
  defmacro __using__(adapter: adapter_ast) do
    quote do
      @diex_adapter unquote(adapter_ast)
      @before_compile {Diex, :generate_dynamic_dispatchers}
    end
  end

  @doc false
  defmacro generate_dynamic_dispatchers(%{module: module}) do
    adapter = Module.get_attribute(module, :diex_adapter)

    module
    |> Module.get_attribute(:callback)
    |> Enum.reverse()
    |> Enum.map(&parse_callback(&1))
    |> Enum.map(fn {function_name, args_ast} ->
      quote do
        defdelegate unquote(function_name)(unquote_splicing(args_ast)), to: unquote(adapter)
      end
    end)
  end

  defp parse_callback({
         :callback,
         {:"::", _line_number, [function_name_and_args_ast, _return_args_ast]},
         {module_name, _}
       }) do
    parse_function_name_and_args(function_name_and_args_ast, module_name)
  end

  defp parse_function_name_and_args({function_name, _line_number, function_args}, module_name) do
    {function_name, parse_function_args(function_args, module_name)}
  end

  defp parse_function_args([], _), do: []

  defp parse_function_args(args, module_name) do
    args
    |> Enum.map(&do_parse_function_arg/1)
    |> Enum.map(&Macro.var(&1, module_name))
  end

  # We are not accepting "unnamed" args for now
  defp do_parse_function_arg(arg) when is_atom(arg) do
    raise ArgumentError,
      message: """
      Diex does not accept unnamed params in the callbacks:
            Error example: @callback my_function(term) :: :ok)
            Instead do:    @callback my_function(something :: term) :: :ok)
      """
  end

  defp do_parse_function_arg(
         {:"::", _line_number, [{param_name, _line_number_2, _metadata}, _type]}
       ) do
    param_name
  end
end
