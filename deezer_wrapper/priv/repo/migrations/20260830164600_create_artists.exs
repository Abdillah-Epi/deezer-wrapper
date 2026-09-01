defmodule DeezerWrapper.Repo.Migrations.CreateArtists do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name, :string, null: false
      add :deezer_id, :integer, null: false
      timestamps()
    end

    create unique_index(:artists, [:deezer_id])
  end
end
