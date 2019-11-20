# frozen_string_literal: true

class String
  # "Encrypt / Decrypt" the string with Caesar cipher. This will shift the
  # alphabet letters by +n+, where +n+ is the integer key. The same function
  # is used for encryption / decryption.
  # @param opts [Hash] optional parameters
  # @option opts [Integer] :shift The shift key. Default value: 13.
  # @see https://en.wikipedia.org/wiki/Caesar_cipher
  # @return [String] the (de)ciphered string
  # @example
  #   'Hello world!'.rot # => "Uryyb jbeyq!"
  #   'Hello world!'.rot(shift: 11) # => "Spwwz hzcwo!"
  #   'Uryyb jbeyq!'.rot # => "Hello world!"
  #   'Spwwz hzcwo!'.rot(shift: 26-11) # => "Hello world!"
  def rot(opts = {})
    opts[:shift] ||= 13
    alphabet = Array('a'..'z')
    lowercase = Hash[alphabet.zip(alphabet.rotate(opts[:shift]))]
    alphabet = Array('A'..'Z')
    uppercasecase = Hash[alphabet.zip(alphabet.rotate(opts[:shift]))]
    encrypter = lowercase.merge(uppercasecase)
    chars.map { |c| encrypter.fetch(c, c) }.join
  end

  # "Encrypt / Decrypt" the string with Caesar cipher in place as described for
  # {String#rot}.
  # @return [String] the (de)ciphered string as well as changing changing the
  #   object in place.
  # @example
  #   a = 'Bonjour le monde !' # => "Bonjour le monde !"
  #   a.rot! # => "Obawbhe yr zbaqr !"
  #   a # => "Obawbhe yr zbaqr !"
  def rot!(opts = {})
    replace(rot(opts))
  end

  # Alias for {#rot} with default value ( +rot(shift: 13)+ ).
  def rot13
    rot
  end

  # Alias for {#rot!} with default value ( +rot!(shift: 13)+ ).
  def rot13!
    rot!
  end
end