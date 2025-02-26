defmodule Igiwindow.MixProject do
  use Mix.Project

  def project do
    [
      app: :igiwindow,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
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
      {:phoenix, "~> 1.7.19"},
      {:phoenix_html, "~> 4.2"},
      {:phoenix_live_view, "~> 1.0.4", override: true},
      {:igniter, "0.5.29", only: [:dev, :test]}
    ]
  end

  defp package() do
    [
      files: ~w(lib priv .formatter.exs mix.exs LICENSE README*)
    ]
  end
end
