defmodule NioGoogleAuthenticator.ChangesetTest do
  use ExUnit.Case
  import NioGoogleAuthenticator
  import NioGoogleAuthenticator.Changeset

  defmodule User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "users" do
      field :name, :string
      field :ga_secret, :string
      field :secret, :integer
    end

    def changeset(user, params \\ %{}) do
      user
      |> cast(params, [])
    end
  end

  test "add_secret_to_changeset adds a new secret to the ga_secret field in a changeset" do
    changeset = User.changeset(%User{})
    changeset = add_secret_to_changeset(changeset)
    assert Ecto.Changeset.get_field(changeset, :ga_secret) != nil
  end

  test "add_secret_to_changeset adds a new secret to an arbitrary field in a changeset" do
    changeset = User.changeset(%User{})
    changeset = add_secret_to_changeset(changeset, :secret)
    assert Ecto.Changeset.get_field(changeset, :secret) != nil
  end

  test "add_secret_to_changeset does not add a new secret if one exists" do
    secret = generate_secret
    changeset = User.changeset(%User{})
    changeset = Ecto.Changeset.put_change(changeset, :ga_secret, secret)
    changeset = add_secret_to_changeset(changeset)
    assert Ecto.Changeset.get_field(changeset, :ga_secret) == secret
  end

  test "regenerate_secret_in_changeset creates a new secret" do
    secret = generate_secret
    changeset = User.changeset(%User{})
    changeset = Ecto.Changeset.put_change(changeset, :ga_secret, secret)
    changeset = regenerate_secret_in_changeset(changeset)
    assert Ecto.Changeset.get_field(changeset, :ga_secret) != secret
  end

  test "regenerate_secret_in_changeset creates a new secret in an arbitrary field" do
    secret = generate_secret
    changeset = User.changeset(%User{})
    changeset = Ecto.Changeset.put_change(changeset, :secret, secret)
    changeset = regenerate_secret_in_changeset(changeset, :secret)
    assert Ecto.Changeset.get_field(changeset, :secret) != secret
  end
end
