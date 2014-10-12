defmodule Dontpanic.Mixfile do
  use Mix.Project

  def project do
    [app: :dontpanic,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     deps: deps,
     guides: guides
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
        {:httpoison, "~> 0.4"}
    ]
  end

  defp guides do
    [
        [
            name: "Nice Guidelines",
            repo: "https://github.com/openhealthcare/nice.panic",
            json: "https://raw.githubusercontent.com/openhealthcare/scrapers/master/example_output/nice.json"
        ]
    ]
  end

end
