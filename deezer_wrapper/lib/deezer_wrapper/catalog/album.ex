defmodule DeezerWrapper.Catalog.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :name, :string
    field :release_date, :date
    belongs_to :artist, DeezerWrapper.Catalog.Artist
    timestamps()
  end

  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name, :release_date])
    |> validate_required([:name, :release_date])
  end
end
