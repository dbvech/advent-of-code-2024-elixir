defmodule Validate do
  def validate(list) do
    Enum.reduce_while(list, {:neutral, nil}, fn x, {dir, prev} ->
      case prev do
        nil ->
          {:cont, {dir, x}}

        _ ->
          diff = x - prev

          curr_dir =
            cond do
              diff < 0 -> :dec
              diff > 0 -> :inc
              true -> :neutral
            end

          cond do
            abs(diff) > 3 or abs(diff) < 1 -> {:halt, nil}
            dir == :neutral or dir == curr_dir -> {:cont, {curr_dir, x}}
            true -> {:halt, nil}
          end
      end
    end) != nil
  end

  def validate_with_dampener(list) do
    validate(list) ||
      Enum.any?(0..(length(list) - 1), &validate(List.delete_at(list, &1)))
  end
end

result =
  File.read!("problem.txt")
  |> String.trim()
  |> String.split(~r{\n})
  |> Enum.map(fn ln ->
    String.split(ln, " ")
    |> Enum.map(&String.to_integer/1)
  end)
  |> Enum.count(&Validate.validate_with_dampener(&1))

IO.inspect(result)
# 301
