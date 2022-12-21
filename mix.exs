defmodule Diex.MixProject do
  use Mix.Project

  def project do
    [
      app: :diex,
      version: "1.0.0",
      elixir: "~> 1.14",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/iuya/diex",
      homepage_url: "https://github.com/iuya/diex"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: []
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", only: :dev, runtime: false},
      {:dialyxir, "~> 1.2", only: :dev, runtime: false},
      {:ex_doc, "~> 0.29.1", only: :dev, runtime: false}
    ]
  end

  defp description() do
    ~S"""
    Dynamic dispatching macros for Elixir.

    Because there is only some many times you can write them before decicing
    to learn how to do macros, automate it and be amazed at the lack of
    circular dependency errors.
    """
  end

  defp package() do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Ignacio Uyá"],
      licenses: ["BSD-2-Clause"],
      links: %{
        "GitHub" => "https://github.com/iuya/diex",
        "Docs" => "https://hexdocs.pm/diex/"
      }
    ]
  end
end
