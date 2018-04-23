defmodule HtmlParty.Mixfile do
  use Mix.Project

  def project do
    [
      app: :html_party,
      description: description(),
      version: "1.0.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: "https://github.com/san650/html_party",
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
      # Test dependencies
      {:phoenix_html, "~> 2.11", only: :test}
    ]
  end

  defp description do
    """
    This library helps you write HTML using regular functions. It provides a small DSL that ensures that you write safe HTML.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/san650/html_party"},
      maintainers: ["Santiago Ferreira"],
      name: :html_party,
    ]
  end
end
