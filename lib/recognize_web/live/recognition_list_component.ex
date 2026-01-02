defmodule RecognizeWeb.RecognitionListComponent do
  use Phoenix.Component

  def table(%{page_type: :received} = assigns) do
    ~H"""
    <div>
      <div>
        <ul role="list" class="divide-y divide-gray-100">
          <%= for recognition <- @recognitions do %>
            <li class="flex justify-between gap-x-6 py-5">
              <div class="flex min-w-0 gap-x-4">
                <img
                  class="size-12 flex-none rounded-full bg-gray-50"
                  src={recognition.sender.image_url}
                  alt=""
                />
                <div class="min-w-0 flex-auto">
                  <p class="text-sm/6 font-semibold text-gray-900"><%= recognition.message %></p>
                  <p class="mt-1 truncate text-xs/5 text-gray-500">
                    <%= recognition.sender.first_name %> recognized you
                  </p>
                </div>
              </div>
              <div class="hidden shrink-0 sm:flex sm:flex-col sm:items-end">
                <p class="text-sm/6 text-gray-900"><%= recognition.sender.email %></p>
                <p class="mt-1 text-xs/5 text-gray-500">
                  Posted
                  <time datetime="2023-01-23T13:23Z">
                    <%= Timex.from_now(recognition.inserted_at) %>
                  </time>
                </p>
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

  def table(assigns) do
    ~H"""
    <div>
      <div>
        <ul role="list" class="divide-y divide-gray-100">
          <%= for recognition <- @recognitions do %>
            <% IO.inspect(recognition) %>
            <li class="flex justify-between gap-x-6 py-5">
              <div class="flex min-w-0 gap-x-4">
                <div class="min-w-0 flex-auto">
                  <p class="text-sm/6 font-semibold text-gray-900"><%= recognition.message %></p>
                  <p class="mt-1 truncate text-xs/5 text-gray-500">
                    You recognized <%= Enum.join(
                      Enum.map(recognition.recipients, & &1.recipient.first_name),
                      ","
                    ) %>
                  </p>
                </div>
              </div>
              <div class="hidden shrink-0 sm:flex sm:flex-col sm:items-end">
                <p class="mt-1 text-xs/5 text-gray-500">
                  Posted
                  <time datetime="2023-01-23T13:23Z">
                    <%= Timex.from_now(recognition.inserted_at) %>
                  </time>
                </p>
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end
end
