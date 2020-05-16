defmodule ChangeProblem.MixProject do
  use Mix.Project

  def project do
    [
      app: :change_problem,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def deps do
    [
      { :matrix, "~> 0.3.0" }
    ]
  end
end
