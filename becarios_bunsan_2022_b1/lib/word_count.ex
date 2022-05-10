defmodule WordCount do
  @moduledoc """
  The following program consists of finding the number of words
  that are repeated in a text that the user can insert.
  """
  def frequencies_tasks(path) do
    mapas =
      path
      |> File.stream!()
      |> Enum.chunk_every(1_00)
      |> Enum.map(fn lines -> Task.async(fn -> word_count(Enum.join(lines)) end) end)
      |> Enum.map(fn task -> Task.await(task) end)

    Enum.reduce(mapas, %{}, fn x, acc ->
      Map.merge(x, acc, fn _k, v1, v2 ->
        v1 + v2
      end)
    end)
  end

  def frecuencies(path) do
    {:ok, doc} = File.read(path)
    word_count(doc)
  end

  def word_count(doc) do
    doc = String.downcase(doc)

    doc1 =
      String.split(doc, [
        ",",
        ";",
        ":",
        ".",
        "_",
        "-",
        "|",
        "°",
        "#",
        "$",
        "%",
        "&",
        "/",
        "(",
        ")",
        "()",
        "{}",
        "=",
        "+",
        "*",
        ">",
        "<",
        "[",
        "]",
        "\r",
        "?",
        "¿",
        "!",
        "¡"
      ])
      |> List.to_string()

    doc2 = String.split(doc1)

    mapa =
      Enum.map(doc2, fn x ->
        cont =
          Enum.count(doc2, fn s ->
            s == x
          end)

        Map.put(%{}, x, cont)
      end)

    Enum.reduce(mapa, %{}, fn x, acc ->
      Map.merge(acc, x)
    end)
  end
end
