# HtmlParty

[DSL](https://en.wikipedia.org/wiki/Domain-specific_language) to write HTML with
pure Elixir functions.

The implementation focuses on simplicity, just leverage to Elixir functions and
on generating **safe** HTML when user input is used.

```ex
defmodule User do
  defstruct [:id, :full_name, :email]
end

defmodule UserRenderer do
  require HtmlParty

  def render(users) do
    HtmlParty.render do
      ul do
        for user <- users do
          user_details user
        end
      end
    end
  end

  defp user_details(%User{} = user) do
    import HtmlParty.Tag

    icon(:user)
    |> HtmlParty.concat(strong user.full_name)
    |> HtmlParty.concat(" ")
    |> HtmlParty.concat(user_link user)
    |> li()
  end

  defp icon(name) do
    # Generates a fontawesome icon using a Phoenix helper
    Phoenix.HTML.Tag.content_tag(:i, "", class: "fa fa-#{name}")
  end

  defp user_link(%User{email: email}) do
    import HtmlParty.Tag

    a email, href: "mailto:#{email}"
  end
end

users = [
  %User{id: 1, full_name: "John Doe", email: "john@example.com"},
  %User{id: 2, full_name: "Jane Roe", email: "jane@example.com"},
]

UserRenderer.render(users)
```

This example would output somthing like this (except the pretty print part!)

```html
<ul>
  <li>
    <i class="fa fa-user"></i>
    <strong>John Doe</strong>
    <a href="mailto:john@example.com">john@example.com</a>
  </li>
  <li>
    <i class="fa fa-user"></i>
    <strong>Jane Roe</strong>
    <a href="mailto:jane@example.com">jane@example.com</a>
  </li>
</ul>
```

## Installation

The package can be installed by adding `html_party` to your list of dependencies in
`mix.exs`:

```elixir
def deps do
  [
    {:html_party, "~> 1.0.0"}
  ]
end
```

## License

HtmlParty is licensed under the MIT license.

See [LICENSE](./LICENSE) for the full license text.
