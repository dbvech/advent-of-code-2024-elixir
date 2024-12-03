case File.read("problem.txt") do
  {:ok, content} ->
    Regex.scan(~r/mul\((\d+),(\d+)\)/, content)
    |> Enum.reduce(0, fn [_, left, right], acc ->
      acc + String.to_integer(left) * String.to_integer(right)
    end)
    |> IO.puts()

  {:error, reason} ->
    IO.puts("Error reading file, reason: #{reason}")
end
