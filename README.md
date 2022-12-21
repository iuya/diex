# Diex

A simple macro to automatically generate dynamic dispatching for a module's callbacks.

Diex introduces a single `use` macro that when used in a module with any callbacks
and given an `adapter` module implementing them, generates it's dynamic dispatchers via
defdelegate.



## Usage w/ Examples

We need a callback module (where the dispatcher will be generated via `use Diex, adapter: Adapter`) where Adapter is any module implementing that behaviour.

```elixir
defmodule Greetable do
  use Diex, adapter: GreetingAdapter
  
  @callback greet() :: String.t()
end

defmodule GreetingAdapter do
  @behaviour Greetable

  @impl Greetable
  def greet(), do: "Hello World!"
end

iex> GreetingAdapter.greet()
"Hello World!"
```

### Defining an adapter in the config files

The only requirement for the adapter argument is that it has a concrete value in compile since that's what `defdelegate` mandates; we could
have runtime adapters by replacing `defdelegate` with a plain old `def` and calling `adapter.function()` inside, but that's for version 2.0.

In any case, we can use `Application.compile_env/2` like so:

```elixir
use Diex, adapter: Application.compile_env(:my_application, :adapters)[__MODULE__]
```

But this is just an example; as long as you can retrieve a module name via `compile_env` it will work.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `diex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:diex, "~> 1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/diex](https://hexdocs.pm/diex).

