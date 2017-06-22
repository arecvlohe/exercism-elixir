defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ", trim: true)
    |> Enum.map(fn(word) -> 
      cond do
        String.starts_with? word, ~w(a e i o u yt xr) -> 
          word <> "ay"
        String.starts_with? word, ~w(squ thr sch) -> 
          String.slice(word, 3..-1) <> String.slice(word, 0, 3) <> "ay"
        String.starts_with? word, ~w(ch qu th) ->
          String.slice(word, 2..-1) <> String.slice(word, 0, 2) <> "ay"
        true ->
          String.slice(word, 1..-1) <> String.slice(word, 0, 1) <> "ay"
      end
    end)
    |> Enum.join(" ")
  end
end

