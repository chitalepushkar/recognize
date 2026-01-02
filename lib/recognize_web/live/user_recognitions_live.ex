defmodule RecognizeWeb.UserRecognitionsLive do
  # In Phoenix v1.6+ apps, the line is typically: use MyAppWeb, :live_view
  use RecognizeWeb, :live_view

  alias Recognize.Accounts
  alias RecognizeWeb.RecognitionListComponent
  alias RecognizeWeb.RecognitionTabsComponent

  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user

    recipient_options =
      current_user.id
      |> Accounts.list_recipients_for_sender()
      |> Enum.map(&{&1.first_name, &1.id})

    {:ok,
     assign(socket,
       recipient_options: recipient_options,
       form: to_form(%{})
     )}
  end

  def handle_params(params, _uri, socket) do
    socket =
      socket
      |> assign_page_type(params)
      |> assign_recognitions(params)

    {:noreply, socket}
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

  defp assign_page_type(socket, %{"page_type" => "received"}) do
    assign(socket, page_type: :received)
  end

  defp assign_page_type(socket, _params) do
    assign(socket, page_type: :sent)
  end

  defp assign_recognitions(socket, %{"page_type" => "received"}) do
    current_user = socket.assigns.current_user
    recognitions = Accounts.list_received_recognitions(current_user.id)
    assign(socket, recognitions: recognitions)
  end

  defp assign_recognitions(socket, _params) do
    current_user = socket.assigns.current_user
    recognitions = Accounts.list_sent_recognitions(current_user.id)
    assign(socket, recognitions: recognitions)
  end
end
