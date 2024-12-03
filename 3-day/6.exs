case File.read("problem.txt") do
  {:ok, content} ->
    without_new_lines = String.replace(content, "\n", "")

    # Removes corrupted sections starting with "don't()" and ending with "do()" or end of line
    without_corrupted = Regex.replace(~r/don't\(\).*?(?:do\(\)|$)/, without_new_lines, "")

    Regex.scan(~r/mul\((\d+),(\d+)\)/, without_corrupted)
    |> Enum.reduce(0, fn [_, left, right], acc ->
      acc + String.to_integer(left) * String.to_integer(right)
    end)
    |> IO.puts()

  {:error, reason} ->
    IO.puts("Error reading file, reason: #{reason}")
end
