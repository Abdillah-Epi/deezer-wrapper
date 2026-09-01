defmodule DeezerWrapperWeb.ArtistController do
  use DeezerWrapperWeb, :controller

  alias DeezerWrapper.Catalog

  def show(conn, %{"name" => name}) do
    case Catalog.get_or_fetch_artist(name) do
      {:ok, artist} ->
        json(conn, %{
          name: artist.name,
          albums:
            Enum.map(artist.albums, fn album ->
              %{name: album.name, release_date: album.release_date}
            end)
        })

      {:error, _reason} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "artist not found"})
    end
  end
end
