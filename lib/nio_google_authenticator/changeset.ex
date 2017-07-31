defmodule NioGoogleAuthenticator.Changeset do
  @moduledoc """
  This module allows a google authenticator secret
  to be inserted into an Ecto.changeset.
  """

  import NioGoogleAuthenticator, only: [generate_secret: 0]
  import Ecto.Changeset, only: [get_field: 2, put_change: 3]

  @doc """
  Adds a secret to an %Echo.Changeset{} if one does not exist

  A custom attribute atom is used if passed otherwise
  defaults to :ga_secret
  """
  def add_secret_to_changeset(changeset, attribute_name \\ :ga_secret) do
    case get_field(changeset, attribute_name) do
      nil -> put_change(changeset, attribute_name, generate_secret())
      _ -> changeset
    end
  end

  @doc """
  Adds a secret to an %Echo.Changeset{}

  An custom attribute is used if passed otherwise
  defaults to :ga_secret
  """
  def regenerate_secret_in_changeset(changeset, attribute_name \\ :ga_secret) do
    put_change(changeset, attribute_name, generate_secret())
  end
end
