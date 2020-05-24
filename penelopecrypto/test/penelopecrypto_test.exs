defmodule PenelopecryptoTest do
  use ExUnit.Case
  doctest Penelopecrypto

  test "Penelopecrypto.main()" do
    assert(Penelopecrypto.main("teste") == "teste")
  end
end
