defmodule Penelopecrypto do
  def main do
    # load the RSA keys from a file on disk
    rsa_priv_key = ExPublicKey.load!("../keys/private_unencrypted.pem")
    rsa_pub_key = ExPublicKey.load!("../keys/public.pem")

    # create the message JSON
    msg = %{"name_first"=>"Chuck","name_last"=>"Norris"}

    # serialize the JSON
    msg_serialized = Poison.encode!(msg)

    # generate time-stamp
    ts = DateTime.utc_now |> DateTime.to_unix

    # add a time-stamp
    ts_msg_serialized = "#{ts}|#{msg_serialized}"

    # generate a secure hash using SHA256 and sign the message with the private key
    {:ok, signature} = ExPublicKey.sign(ts_msg_serialized, rsa_priv_key)

    # combine payload
    payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64 signature}"
    IO.puts payload

    # pretend transmit the message...
    # pretend receive the message...

    # break up the payload
    parts = String.split(payload, "|")
    recv_ts = Enum.fetch!(parts, 0)
    recv_msg_serialized = Enum.fetch!(parts, 1)
    {:ok, recv_sig} = Enum.fetch!(parts, 2) |> Base.url_decode64

    # pretend ensure the time-stamp is not too old (or from the future)...
    # it should probably no more than 5 minutes old, and no more than 15 minutes in the future

    # verify the signature
    {:ok, sig_valid} = ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig, rsa_pub_key)
    assert(sig_valid)

    # un-serialize the JSON
    recv_msg_unserialized = Poison.Parser.parse!(recv_msg_serialized)
    assert(msg == recv_msg_unserialized)
  end
end
