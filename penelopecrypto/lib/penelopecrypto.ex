defmodule Penelopecrypto do
  def main(plaintext) do
    # load the RSA keys from a file on disk
    private_key = File.read!("keys/private_unencrypted.pem") |> RSA.decode_key
    public_key = File.read!("keys/public.pem") |> RSA.decode_key
    # Encrypt a string using the public key and decrypt it using the private key
    cyphertext = plaintext |> RSA.encrypt({:public, public_key}) # << ... encrypted binary data ... >>
    # Encode it to base64
    encrypted_b64 = :base64.encode_to_string cyphertext # "... base64 ASCII text ..."
    # Decode a base64 encrypted string and decrypt it
    cyphertext = :base64.decode encrypted_b64
    plaintext = cyphertext |> RSA.decrypt({:private, private_key})
    IO.puts encrypted_b64
    IO.puts plaintext
    plaintext
  end

  def generate_rsa do
    {pem, 0} = System.cmd("openssl", ["genrsa","2048"])
    {:RSAPrivateKey, :'two-prime', n , e, d, _p, _q, _e1, _e2, _c, _other} = pem
        |> :public_key.pem_decode
        |> List.first
        |> :public_key.pem_entry_decode

    IO.puts pem
    {e, n, d}
  end
end
