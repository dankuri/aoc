# substitute DAY with day number (%s/DAY/7/g) and remove this comment
defmodule DayDAY do
  def part1(input) do
    nil
    |> IO.inspect(label: "part 1")
  end

  def part2(input) do
    nil
    |> IO.inspect(label: "part 2")
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map()
  end
end

# example input
input = """

"""

# input = File.read!("./inputs/dayDAY.txt")

DayDAY.part1(input)
DayDAY.part2(input)
