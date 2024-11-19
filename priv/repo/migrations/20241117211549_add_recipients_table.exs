defmodule Recognize.Repo.Migrations.AddRecipientsTable do
  use Ecto.Migration

  def change do
    create table(:recipients, primary_key: false) do
      add :recognition_id, references(:recognitions), null: false
      add :recipient_id, references(:users), null: false

      timestamps()

      unique_index(:recipients, [:recognition_id, :recipient_id])
    end
  end
end
