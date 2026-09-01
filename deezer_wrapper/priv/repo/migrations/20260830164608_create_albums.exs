defmodule DeezerWrapper.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string, null: false
      add :release_date, :date
      add :artist_id, references(:artists, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:albums, [:artist_id])
  end
end
