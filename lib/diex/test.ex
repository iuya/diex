defmodule Diex.Test do
  @moduledoc false

  require Diex.DispatcherBuilder

  @callback test(integer()) :: integer()

  Diex.DispatcherBuilder.build(:test, 1, Diex.Test.Adapter)

  defmodule Adapter do
    @moduledoc false
    def test(int), do: int * 10_000
  end
end
