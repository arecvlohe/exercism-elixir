defmodule Bob do
  def hey(input) do
    
    is_question =
      String.ends_with? input, "?"

    is_empty =
      (String.trim(input) |> String.length) == 0

    contains_all_uppercase =
      input
      |> String.replace(~r/[^\p{Lu}\p{Ll}\\s+]/, "")
      |> String.split("", trim: true)
      |> Enum.all?(fn(v) -> v =~ ~r/^\p{Lu}$/u end)

    cond do
        is_question            -> "Sure."
        is_empty               -> "Fine. Be that way!"
        contains_all_uppercase -> "Whoa, chill out!"
        true                   -> "Whatever."
    end
  end
end
