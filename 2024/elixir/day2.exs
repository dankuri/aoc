defmodule Day2 do
  def part1(input) do
    parse(input)
    |> Enum.map(&safe_p1?/1)
    |> Enum.count(& &1)
    |> IO.inspect(label: "part 1")
  end

  def part2(input) do
    parse(input)
    |> Enum.map(&safe_p2?/1)
    |> Enum.count(& &1)
    |> IO.inspect(label: "part 2")
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn str_list -> Enum.map(str_list, &String.to_integer/1) end)
  end

  def safe_p1?(levels) do
    [last_lvl | [next_lvl | rest]] = levels
    diff = last_lvl - next_lvl

    cond do
      diff == 0 || abs(diff) > 3 -> false
      diff < 0 -> do_safe?([next_lvl | rest], :incr, false)
      true -> do_safe?([next_lvl | rest], :decr, false)
    end
  end

  def safe_p2?(levels) do
    [last_lvl | [next_lvl | rest]] = levels
    diff = last_lvl - next_lvl

    cond do
      diff == 0 || abs(diff) > 3 ->
        next_diff = next_lvl - hd(rest)
        last_diff = last_lvl - hd(rest)

        cond do
          next_diff != 0 && abs(next_diff) < 4 ->
            dir = if next_diff < 0, do: :incr, else: :decr
            do_safe?([hd(rest) | tl(rest)], dir, false)

          last_diff != 0 && abs(last_diff) < 4 ->
            dir = if last_diff < 0, do: :incr, else: :decr
            do_safe?([hd(rest) | tl(rest)], dir, false)

          true ->
            false
        end

      diff < 0 ->
        do_safe?([next_lvl | rest], :incr, true)

      true ->
        do_safe?([next_lvl | rest], :decr, true)
    end
  end

  defp do_safe?(levels, dir, tolerate?)

  defp do_safe?([last_lvl | [next_lvl | rest]], :incr, tolerate?) do
    diff = last_lvl - next_lvl

    if diff == 0 || abs(diff) > 3 || diff > 0 do
      if tolerate? do
        do_safe?([next_lvl | rest], :incr, false)
      else
        false
      end
    else
      do_safe?([next_lvl | rest], :incr, tolerate?)
    end
  end

  defp do_safe?([last_lvl | [next_lvl | rest]], :decr, tolerate?) do
    diff = last_lvl - next_lvl

    if diff == 0 || abs(diff) > 3 || diff < 0 do
      if tolerate? do
        do_safe?([next_lvl | rest], :incr, false)
      else
        false
      end
    else
      do_safe?([next_lvl | rest], :decr, tolerate?)
    end
  end

  defp do_safe?([_last_lvl], _, _), do: true
end

# example input
_input = """
48 46 47 49 51 54 56
1 1 2 3 4 5
1 2 3 4 5 5
5 1 2 3 4 5
1 4 3 2 1
1 6 7 8 9
1 2 3 4 3
9 8 7 6 7
"""

input = File.read!("./inputs/day2.txt")

# Day2.part1(input)
Day2.part2(_input)
