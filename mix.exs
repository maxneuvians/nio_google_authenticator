defmodule NioGoogleAuthenticator.Mixfile do
  use Mix.Project

  def project do
    [app: :nio_google_authenticator,
     version: "1.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ecto, "~> 1.1"},
      {:pot, git: "https://github.com/yuce/pot.git"}
    ]
  end

  defp description do
    """
    NioGoogleAuthenticator is a collection of Elixir convenience functions
    to generate secrets and validate tokens used in conjunction with Google
    Authenticator. It also includes functions that automatically add a secret to
    an Ecto.Changeset.
    """
  end

  defp package do
    [# These are the default files included in the package
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Max Neuvians"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/maxneuvians/nio_google_authenticator",
              "Docs" => "https://github.com/maxneuvians/nio_google_authenticator"}]
  end
end
