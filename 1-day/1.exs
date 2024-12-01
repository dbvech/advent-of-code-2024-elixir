result =
  File.read!("problem.txt")
  |> String.trim()
  |> String.split("\n")
  |> Enum.map(fn ln ->
    String.split(ln, ~r{\s+}) |> Enum.map(&String.to_integer/1) |> List.to_tuple()
  end)
  |> Enum.unzip()
  |> then(fn {left, right} -> Enum.zip(Enum.sort(left), Enum.sort(right)) end)
  |> Enum.map(fn {x, y} -> abs(x - y) end)
  |> Enum.sum()

IO.inspect(result)
# 1651298
