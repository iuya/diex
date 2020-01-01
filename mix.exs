defmodule Diex.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :diex,
      version: "0.0.1",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp description() do
    ~S"""
    Dependency injection and dynamic dispatching macros for Exilir.
    """
  end

  defp package() do
    [
      files: ["lib", "mix.exs", "README.md", "COPYING"],
      maintainers: ["Ignacio Uyá"],
      licenses: ["GNU GPLv3"],
      links: %{
        "GitHub" => "https://github.com/iuya/diex",
        "Docs" => "https://hexdocs.pm/diex/"
      }
    ]
  end
end
