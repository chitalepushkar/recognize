defmodule RecognizeWeb.RecognitionTabsComponent do
  use Phoenix.Component

  use Phoenix.VerifiedRoutes,
    endpoint: RecognizeWeb.Endpoint,
    router: RecognizeWeb.Router

  attr :page_type, :atom, default: :sent

  def tabs(assigns) do
    ~H"""
    <div class="text-sm font-medium text-center text-body border-b border-default">
      <ul class="flex flex-wrap -mb-px">
        <li class="me-2">
          <.link
            navigate={~p"/users/recognitions?page_type=sent"}
            class={selected_tab_class(@page_type, :sent)}
          >
            Sent
          </.link>
        </li>
        <li class="me-2">
          <.link
            navigate={~p"/users/recognitions?page_type=received"}
            class={selected_tab_class(@page_type, :received)}
          >
            Received
          </.link>
        </li>
      </ul>
    </div>
    """
  end

  defp selected_tab_class(current_page_type, tab_page_type) do
    if current_page_type == tab_page_type do
      "inline-block p-4 text-fg-brand border-b border-brand rounded-t-base active"
    else
      "inline-block p-4 border-b border-transparent rounded-t-base hover:text-fg-brand hover:border-brand"
    end
  end
end
