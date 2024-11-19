defmodule RecognizeWeb.UserRecognitionsLive do
  # In Phoenix v1.6+ apps, the line is typically: use MyAppWeb, :live_view
  use RecognizeWeb, :live_view

  alias Recognize.Accounts

  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    # Let's assume a fixed temperature for now
    recipient_options =
      current_user.id
      |> Accounts.list_recipients_for_sender()
      |> Enum.map(&{&1.first_name, &1.id})

    recognitions = Accounts.list_received_recognitions(current_user.id)

    {:ok,
     assign(socket,
       recognitions: recognitions,
       recipient_options: recipient_options,
       form: to_form(%{})
     )}
  end

  def handle_event("save", params, socket) do
    sender_id = socket.assigns.current_user.id
    recipient_ids = Map.get(params, "recipients")
    message = Map.get(params, "message")

    case Accounts.create_recognition(sender_id, recipient_ids, message) do
      {:ok, _recognition} ->
        {:noreply,
         socket
         |> put_flash(:info, "Team member recognition sent")
         |> redirect(to: ~p"/users/recognitions")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
