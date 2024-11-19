defmodule Recognize.Repo.Migrations.AddRecognitionsTable do
  use Ecto.Migration

  def change do
    create table(:recognitions) do
      add :sender_id, references(:users), null: false
      add :message, :text, null: false

      timestamps()
    end
  end
end
