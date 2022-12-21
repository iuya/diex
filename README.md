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

