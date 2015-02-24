defmodule SpiderMonkey.Mixfile do
  use Mix.Project

  def project do
    [app: :estree,
     version: "1.0.0",
     elixir: "~> 1.0",
     deps: deps,
     description: description,
     package: package,
     source_url: "https://github.com/bryanjos/elixir-estree"]
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

  defp description do
    """
    The SpiderMonkey AST definitions. Mostly following the ESTree Spec
    """
  end

  defp package do
    [ # These are the default files included in the package
      files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*", "CHANGELOG*"],
      contributors: ["Bryan Joseph"],
      licenses: ["MIT"],
      links: %{ 
        "GitHub" => "https://github.com/bryanjos/elixir-spidermonkey", 
        "SpiderMonkey Parser API" => "https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API",
        "ESTree" => "https://github.com/estree/estree" }
    ]
  end
end
