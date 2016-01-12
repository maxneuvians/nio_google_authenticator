# NioGoogleAuthenticator

NioGoogleAuthenticator is a collection of Elixir convenience functions to generate secrets and validate tokens used in conjunction with Google Authenticator. It also includes functions that automatically add a secret to an `Ecto.Changeset`.

## Installation
Add `nio_google_authenticator` to your list of dependencies in `mix.exs`:
```
def deps do
[{:nio_google_authenticator, "~> 1.0.1"}]
end
```

## Usage

##### Creating a secret:

`.generate_secret`

##### Creating a token:

`.generate_token(secret)`

This method is best used for automatic testing.

##### Creating the URL that yields a scannable QR code for a Google Authenticator mobile app:

`.generate_url(secret, label, issuer \\ @issuer)`

where issuer can be configured universally using:

`config :nio_google_authenticator, issuer: "Neuvians.io"`

This will yield a URL in the following format:

`https://chart.googleapis.com/chart?cht=qr&chs=200x200&chl=otpauth%3A%2F%2Ftotp%2FLABEL%3Fissuer%3DISSUER%26secret%3DBM7SUJ4MLRN2UPI6`

##### Validating a token

`.validate_token(secret, token)`

this will either return `{:ok, :pass}` or `{:error, :invalid_token}`

## Ecto.Changeset usage
There are two additional functions which you can pass an `Ecto.Changeset` which will automatically add a secret to the changeset. For both function you can specify the attribute to change (ex. `.add_secret_to_changeset(changeset, :my_secret_field)`) but if none is specified `:ga_secret` is used.

##### Adding a secret to a changeset
To add a secret inside a changeset pipe you can call `add_secret_to_changeset(changeset)`. This will only add the secret if the passed attribute or `:ga_secret` is `nil`. Otherwise it is ignored.

##### Regenerating a secret in a changeset
If you would like to renegerate a secret you can use `.regenerate_secret_in_changeset(changeset)` which will always replace an existing value.

##### Example in Ecto.Model
```
defmodule User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "users" do
      field :name, :string
      field :ga_secret, :string
    end

    def changeset(user, params \\ :empty) do
      user
      |> cast(params, ~w(name), ~w(ga_secret))
      |> NioGoogleAuthenticator.Changeset.add_secret_to_changeset
    end
  end
 ```

### Version
1.0.1

License
----
MIT
