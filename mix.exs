defmodule NioGoogleAuthenticator.Mixfile do
  use Mix.Project

  def project do
    [app: :nio_google_authenticator,
     version: "0.5.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ecto, "~> 1.1"},
      {:pot, git: "https://github.com/yuce/pot.git"}
    ]
  end
end
