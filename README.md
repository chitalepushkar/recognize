# Recognize

An app to recognize team members for their contributions.

## Data Model

```mermaid
erDiagram;
	recognitions ||--o{ recipients : has
	recipients ||--|| users : has

	users {
		id UUID
		first_name string "NOT NULL"
		last_name string
	
	}
	
	recipients {
		recipient_id UUID FK "NOT NULL"
		recognition_id UUID FK "NOT NULL"
	}
	
	recognitions {
		id UUID
		sender_id UUID FK "NOT NULL"
		message text "NOT NULL"
	}
```

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
