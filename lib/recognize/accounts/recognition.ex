defmodule Recognize.Accounts.Recognition do
  use Recognize.Schema

  alias Recognize.Accounts.Recipient
  alias Recognize.Accounts.User

  schema "recognitions" do
    belongs_to :sender, User
    field :message, :string

    has_many :recipients, Recipient

    timestamps()
  end

  def changeset(recognition \\ %__MODULE__{}, attrs, opts \\ []) do
    recognition
    |> cast(attrs, [:sender_id, :message])
    |> cast_assoc(:recipients)
  end

  def where_recipient_id(query \\ __MODULE__, user_id) do
    from recognition in query,
      join: recipient in assoc(recognition, :recipients),
      join: user in User,
      on: user.id == recipient.recipient_id,
      where: recipient.recipient_id == ^user_id,
      preload: [:sender],
      order_by: [desc: recognition.inserted_at]
  end

  def where_sender_id(query \\ __MODULE__, user_id) do
    from recognition in query,
      join: recipient in assoc(recognition, :recipients),
      join: user in User,
      on: user.id == recipient.recipient_id,
      where: recognition.sender_id == ^user_id,
      preload: [recipients: [:recipient]],
      group_by: recognition.id,
      order_by: [desc: recognition.inserted_at]
  end
end
