defmodule Recognize.Accounts.Recipient do
  use Recognize.Schema

  alias Recognize.Accounts.Recognition
  alias Recognize.Accounts.User

  @primary_key false
  schema "recipients" do
    belongs_to :recipient, User
    belongs_to :recognition, Recognition

    timestamps()
  end

  def changeset(recipient \\ %__MODULE__{}, attrs) do
    cast(recipient, attrs, [:recognition_id, :recipient_id])
  end
end
