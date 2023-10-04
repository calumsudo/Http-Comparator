defmodule HttpComparator.CLI do
  def main(_args) do
    IO.puts("This program accepts 2 Json files, it will compare the two\n" <>
       "assuming that the first Json entered is the original and the second\n" <>
       "Json entered is the one with changes, additions, or deletions")

    IO.puts("Enter path for JSON 1:")
    file1 = IO.gets("> ") |> String.trim()

    IO.puts("Enter path for JSON 2:")
    file2 = IO.gets("> ") |> String.trim()

    json1 = File.read!(file1)
    json2 = File.read!(file2)

    result = HttpComparator.compare(json1, json2)

    IO.puts("Comparison Result:")
    IO.inspect(result)
  end
end
