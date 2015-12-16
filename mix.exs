defmodule Sudoku.Mixfile do
  use Mix.Project

  def project do
    [app: :sudoku,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
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
    # https://chodounsky.net/2015/06/16/running-exunit-tests-when-file-changes/
    # mix deps.get && mix text.watch
    [{:mix_test_watch, "~> 0.1.1"}]
  end
end
