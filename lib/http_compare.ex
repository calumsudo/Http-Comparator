defmodule HttpCompare do
  @spec compare(String.t(), String.t()) :: any
  def compare(json1, json2) do
    data1 = Jason.decode!(json1)
    data2 = Jason.decode!(json2)

    {comparisons, unmatched} = compare_data_sets(data1, data2)
    new_sets = Enum.map(unmatched, fn req -> {:request_added, req} end)

    comparisons ++ new_sets
  end

  defp compare_data_sets(data1, data2) do
    Enum.reduce(data1, {[], data2}, fn req1, {acc, remaining_data2} ->
      case find_matching_request(req1, remaining_data2) do
        {req2, new_remaining_data2} when is_map(req2) ->
          {[compare_request_pair(req1, req2, data1, data2) | acc], new_remaining_data2}
        _ ->
          {[{:request_removed, req1} | acc], remaining_data2}
      end
    end)
  end

  defp find_matching_request(req1, data) do
    matched_req = Enum.find(data, fn r -> r["request"]["url"] == req1["request"]["url"] and r["request"]["method"] == req1["request"]["method"] end)

    if matched_req do
      {matched_req, List.delete(data, matched_req)}
    else
      {nil, data}
    end
  end

  defp compare_request_pair(req1, req2, data1, data2) do
    %{
      overall_order: compare_overall_order(req1, req2, data1, data2),
      header_order: compare_order(req1, req2),
      request_headers: compare_headers(req1["request"]["headers"], req2["request"]["headers"]),
      response_headers: compare_headers(req1["response"]["headers"], req2["response"]["headers"]),
      url: compare_values(req1["request"]["url"], req2["request"]["url"]),
      method: compare_values(req1["request"]["method"], req2["request"]["method"]),
      status_code: compare_values(req1["response"]["status_code"], req2["response"]["status_code"]),
      status_text: compare_values(req1["response"]["status_text"], req2["response"]["status_text"])
    }
  end

  defp compare_overall_order(req1, req2, data1, data2) do
    index1 = Enum.find_index(data1, fn r -> r["request"]["url"] == req1["request"]["url"] and r["request"]["method"] == req1["request"]["method"] end)
    index2 = Enum.find_index(data2, fn r -> r["request"]["url"] == req2["request"]["url"] and r["request"]["method"] == req2["request"]["method"] end)

    if index1 == index2, do: :same_order, else: :different_order
  end

  defp compare_order(%{"request" => r1, "response" => resp1}, %{"request" => r2, "response" => resp2}) do
    cond do
      header_names_match?(r1["headers"], r2["headers"]) and header_names_match?(resp1["headers"], resp2["headers"]) -> :same_order
      true -> :different_order
    end
  end

  defp header_names_match?(headers1, headers2) do
    names1 = Enum.map(headers1, &(&1["name"]))
    names2 = Enum.map(headers2, &(&1["name"]))
    names1 == names2
  end

  defp compare_headers(headers1, headers2) do
    header_names1 = Enum.map(headers1, fn h -> h["name"] end)
    header_names2 = Enum.map(headers2, fn h -> h["name"] end)

    added = header_names2 -- header_names1
    removed = header_names1 -- header_names2
    value_changes = headers_value_changes(headers1, headers2)

    [added_headers: added, removed_headers: removed, value_changes: value_changes]
  end

  defp headers_value_changes(headers1, headers2) do
    Enum.reduce(headers1, [], fn h1, acc ->
      h2 = Enum.find(headers2, &(&1["name"] == h1["name"]))
      if h2 && h1["value"] != h2["value"] do
        [{h1["name"], h1["value"], h2["value"]}|acc]
      else
        acc
      end
    end)
  end

  defp compare_values(val1, val2) when val1 == val2, do: {:same, val1}
  defp compare_values(val1, val2), do: {:changed, {val1, val2}}
end
