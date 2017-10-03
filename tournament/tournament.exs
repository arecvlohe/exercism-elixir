defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do

    # tallies: matches played, wins, loses, draws, points
    # ordered by points

    # Tally up the points
    tallies =
      input
      |> Enum.reduce(%{}, fn curr, acc ->

        match = Regex.match?(~r/^\w+\s\w+;\w+\s\w+;(loss|win|draw)$/, curr)

        cond do
          match == false ->
            acc
          true ->
            [team1, team2, result] = String.split(curr, ";", trim: true)
            acc = Map.put_new(acc, team1, %{mp: 0, w: 0, l: 0, d: 0, p: 0})
            acc = Map.put_new(acc, team2, %{mp: 0, w: 0, l: 0, d: 0, p: 0})

            case result do
              "win" ->
                acc = update_in(acc, [team1, :w], &(&1 + 1))
                acc = update_in(acc, [team1, :p], &(&1 + 3))
                acc = update_in(acc, [team2, :l], &(&1 + 1))
              "loss" ->
                acc = update_in(acc, [team1, :l], &(&1 + 1))
                acc = update_in(acc, [team2, :w], &(&1 + 1))
                acc = update_in(acc, [team2, :p], &(&1 + 3))
              "draw" ->
                acc = update_in(acc, [team1, :d], &(&1 + 1))
                acc = update_in(acc, [team1, :p], &(&1 + 1))
                acc = update_in(acc, [team2, :d], &(&1 + 1))
                acc = update_in(acc, [team2, :p], &(&1 + 1))
            end
            acc = update_in(acc, [team1, :mp], &(&1 + 1))
            acc = update_in(acc, [team2, :mp], &(&1 + 1))
        end

        end)
        |> Map.to_list
        |> Enum.sort_by(fn { team, map } -> map[:p] end, &>=/2)

    # Header
    header = String.pad_trailing("Team", 31, " ") <> "| MP |  W |  D |  L |  P"
    # Boday
    body =
      tallies
      |> Enum.map(fn team ->
        { name, %{ mp: mp, w: w, d: d, l: l, p: p } } = team
        left = String.pad_trailing(name, 31, " ")
        right =  Enum.reduce([mp, w, d, l, p], "", fn v, acc ->
          acc <> "|  " <> Integer.to_string(v) <> " "
        end)
        left <> String.trim(right)
      end)
      |> Enum.join("\n")

    # Table
    header <> "\n" <> body
  end
end

