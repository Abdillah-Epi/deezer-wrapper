defmodule DeezerWrapper.Catalog do
  import Ecto.Query

  alias DeezerWrapper.Repo
  alias DeezerWrapper.Catalog.Artist
  alias DeezerWrapper.DeezerClient

  def get_or_fetch_artist(name) do
    case get_artist_by_name(name) do
      nil ->
        fetch_and_store_artist(name)

      artist ->
        {:ok, Repo.preload(artist, :albums)}
    end
  end

  defp get_artist_by_name(name) do
    Repo.one(
      from a in Artist, where: fragment("lower(?)", a.name) == ^String.downcase(name)
    )
  end

  defp fetch_and_store_artist(name) do
    with {:ok, deezer_data} <- DeezerClient.search_artist(name) do
      case Repo.get_by(Artist, deezer_id: deezer_data["id"]) do
        nil -> insert_artist(deezer_data)
        artist -> {:ok, Repo.preload(artist, :albums)}
      end
    end
  end

  defp insert_artist(deezer_data) do
    with {:ok, albums} <- DeezerClient.get_albums(deezer_data["id"]) do
      %Artist{}
      |> Artist.changeset(%{
        name: deezer_data["name"],
        deezer_id: deezer_data["id"],
        albums: albums
      })
      |> Repo.insert()
    end
  end
end
