defmodule SpiderMonkey.Mixfile do
  use Mix.Project

  def project do
    [app: :spider_monkey,
     version: "1.0.0",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :poison]]
  end

  defp deps do
    [
      {:poison, "~> 1.3"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      {:dialyze, "~> 0.1.3", only: :dev}
    ]
  end
end
