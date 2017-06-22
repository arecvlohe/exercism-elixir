defmodule RotationalCipher do

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(fn(char) ->
      cond do
        char in ?a..?z -> ?a + rem(char - ?a + shift, 26)
        char in ?A..?Z -> ?A + rem(char - ?A + shift, 26)
        true -> char
      end
    end)
    |> to_string
    # text
    # |> String.to_charlist
    # |> Enum.map(fn(v) ->
    #   case {Enum.member?(65..90, v), Enum.member?(97..122, v), v + shift} do
    #     # Uppercase letters
    #     {true, _, r} ->
    #       if r > 90, do: rem(r - 90, 26) + 64, else: r
    #     # Lowercase letters
    #     {_, true, r} ->
    #       if r > 122, do: rem(r - 122, 26) + 96, else: r
    #     # Special characters
    #     {false, false, _} ->
    #       v
    #   end
    # end)
    # |> to_string
  end
end

