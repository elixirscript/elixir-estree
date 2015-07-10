defmodule ESTree.Mixfile do
  use Mix.Project

  def project do
    [app: :estree,
     version: "2.0.0-dev",
     elixir: "~> 1.0",
     deps: deps,
     description: description,
     package: package,
     source_url: "https://github.com/bryanjos/elixir-estree"]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      {:dialyze, "~> 0.1.3", only: :dev},
      {:shouldi, only: :test}
    ]
  end

  defp description do
    """
    Defines structs that represent the SpiderMonkey AST definitions. Mostly following the ESTree Spec. Targets ES6 definitions
    """
  end

  defp package do
    [ # These are the default files included in the package
      files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*", "CHANGELOG*"],
      contributors: ["Bryan Joseph"],
      licenses: ["MIT"],
      links: %{ "GitHub" => "https://github.com/bryanjos/elixir-estree" }
    ]
  end
end
