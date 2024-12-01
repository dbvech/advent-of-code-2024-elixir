{left, right} =
  File.read!("problem.txt")
  |> String.trim()
  |> String.split("\n")
  |> Enum.map(fn ln ->
    String.split(ln, ~r{\s+}) |> Enum.map(&String.to_integer/1) |> List.to_tuple()
  end)
  |> Enum.unzip()

frequencies = Enum.frequencies(right)

result =
  left
  |> Enum.map(fn l -> l * Map.get(frequencies, l, 0) end)
  |> Enum.sum()

IO.inspect(result)
# 21306195 
