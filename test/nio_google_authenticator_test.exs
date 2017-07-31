defmodule NioGoogleAuthenticatorTest do
  use ExUnit.Case
  import NioGoogleAuthenticator

  test "generate_secret() returns a 32 bit encoded string" do
    secret = generate_secret()
    assert {:ok, _} = Base.decode32(secret)
  end

  test "generate_token creates a valid token" do
    secret = generate_secret()
    token = generate_token(secret)
    assert {:ok, :pass} = validate_token(secret, token)
  end

  test "generate_token creates a valid token based on a secret of length 6" do
    secret = generate_secret()
    assert generate_token(secret) |> String.length == 6
  end

  test "generate_url creates a Google QR code url with the correct secret" do
    secret = generate_secret()
    assert generate_url(secret, "LABEL") =~ secret
  end

  test "generate_url accepts a label and adds it to the URL" do
    secret = generate_secret()
    assert generate_url(secret, "LABEL") =~ "LABEL"
  end

  test "generate_url accepts an optional issuer and adds it to the URL" do
    secret = generate_secret()
    assert generate_url(secret, "LABEL", "ISSUER") =~ "ISSUER"
  end

  test "generate_url uses a configured issuer if one is not passed" do
    secret = generate_secret()
    assert generate_url(secret, "LABEL") =~
      URI.encode_www_form(Application.get_env(:nio_google_authenticator, :issuer))
  end

  test "validate_token returns {:ok, :pass} when a correct token is used" do
    Enum.each(0..10, fn(_) ->
      secret = generate_secret()
      assert {:ok, :pass} = validate_token(secret, :pot.totp(secret))
    end)
  end

  test "validate_token returns {:error, :invalid_token} when an incorrect token is used based on token_length options" do
    secret = generate_secret()
    assert {:error, :invalid_token} = validate_token(secret, :pot.totp(secret), [token_length: 3])
  end

  test "validate_token returns {:error, :invalid_token} when an incorrect token is used" do
    secret = generate_secret()
    assert {:error, :invalid_token} = validate_token(secret, "ABCDEF")
  end

  test "validate_token returns {:error, 'Both secret and token must be strings'} if something else than a string is passed" do
    assert {:error, "Both secret and token must be strings"} = validate_token(123, "ABCDEF")
    assert {:error, "Both secret and token must be strings"} = validate_token("ABCDEF", 123)
  end
end
