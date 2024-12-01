defmodule Day1 do
  def part1(input) do
    {left, right} = parse_input(input)

    Enum.zip(Enum.sort(left), Enum.sort(right))
    |> Enum.map(fn {l, r} -> abs(l - r) end)
    |> Enum.sum()
    |> IO.inspect(label: "part 1")
  end

  def part2(input) do
    {left, right} = parse_input(input)
    freq = Enum.frequencies(right)

    left
    |> Enum.map(&(&1 * Map.get(freq, &1, 0)))
    |> Enum.sum()
    |> IO.inspect(label: "part 2")
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.reduce({[], []}, fn [l, r], {l_acc, r_acc} ->
      {[String.to_integer(l) | l_acc], [String.to_integer(r) | r_acc]}
    end)
  end
end

_input = """
3   4
4   3
2   5
1   3
3   9
3   3
"""

input = File.read!("./inputs/day1.txt")

Day1.part1(input)
Day1.part2(input)
