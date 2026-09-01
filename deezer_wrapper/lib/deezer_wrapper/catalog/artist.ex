defmodule DeezerWrapper.Catalog.Artist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field :name, :string
    field :deezer_id, :integer

    has_many :albums, DeezerWrapper.Catalog.Album

    timestamps()
  end

  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [:name, :deezer_id])
    |> validate_required([:name, :deezer_id])
    |> unique_constraint(:deezer_id)
    |> cast_assoc(:albums, with: &DeezerWrapper.Catalog.Album.changeset/2)
  end
end
