defmodule DeezerWrapper.DeezerClient do
  @base_url "https://api.deezer.com"

  def search_artist(name) do
    url = "#{@base_url}/search/artist"

    case Req.get(url, params: [q: name]) do
      {:ok, %Req.Response{status: 200, body: %{"data" => []}}} ->
        {:error, :not_found}

      {:ok, %Req.Response{status: 200, body: %{"data" => artists}}} ->
        {:ok, find_best_match(artists, name)}

      {:ok, %Req.Response{status: status}} ->
        {:error, {:deezer_error, status}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp find_best_match(artists, query) do
    artists
    |> Enum.filter(&(String.downcase(&1["name"]) == String.downcase(query)))
    |> case do
      [] -> List.first(artists)
      exact_matches -> Enum.max_by(exact_matches, & &1["nb_fan"])
    end
  end

  def get_albums(artist_id) do
    url = "#{@base_url}/artist/#{artist_id}/albums"

    with {:ok, raw_albums} <- fetch_all_albums(url, []) do
      albums =
        Enum.map(raw_albums, fn album ->
          %{name: album["title"], release_date: album["release_date"]}
        end)

      {:ok, albums}
    end
  end

  defp fetch_all_albums(nil, acc), do: {:ok, acc}

  defp fetch_all_albums(url, acc) do
    case Req.get(url) do
      {:ok, %Req.Response{status: 200, body: %{"data" => albums} = body}} ->
        fetch_all_albums(body["next"], acc ++ albums)

      {:ok, %Req.Response{status: status}} ->
        {:error, {:deezer_error, status}}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
