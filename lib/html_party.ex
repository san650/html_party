defmodule HtmlParty do
  @moduledoc ~S"""
  HtmlParty is a DSL for generating HTML using plain functions.

  It leverages to Phoenix.HTML helpers to make sure the generated HTML is safe
  when user input is used to avoid XSS injections.

  ## Example

      defmodule User do
        defstruct [:id, :full_name, :email]
      end

      defmodule UserRenderer do
        require HtmlParty

        def render(users) do
          HtmlParty.render do
            ul do
              for user <- users do
              end
            end
          end
        end
      end

      users = [
        %User{id: 1, full_name: "John Doe", email: "john@example.com"},
        %User{id: 2, full_name: "Jane Roe", email: "jane@example.com"},
        %User{id: 3, full_name: "<script>alert('hacked');</script>", email: nil},
      ]

      UserRenderer.render(users)

      # Outputs:
      # <ul>
      #   <li>
      #     <a href="http://example.com/users/1">John Doe</a>
      #   </li>
      #   <li>
      #     <a href="http://example.com/users/2">Jane Roe</a>
      #   </li>
      #   <li>
      #     <a href="http://example.com/users/3">&lt;script&gt;alert(&#39;hacked&#39;);&lt;/script&gt;</a>
      #   </li>
      # </ul>

  Note that the output is *not* pretty printed!

  You can use regular functions to _componetize_ your html as shown below.

  ## Example

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

      # Outputs:
      # <ul>
      #   <li>
      #     <i class="fa fa-user"></i>
      #     <strong>John Doe</strong>
      #     <a href="mailto:john@example.com">john@example.com</a>
      #   </li>
      #   <li>
      #     <i class="fa fa-user"></i>
      #     <strong>Jane Roe</strong>
      #     <a href="mailto:jane@example.com">jane@example.com</a>
      #   </li>
      # </ul>
  """

  @doc """
  Macro that helps rendering a block of HTML.

  ## Examples

      iex> HtmlParty.render(do: "Hello, World!")
      "Hello, World!"

      iex> HtmlParty.render do
      ...>   span "Hello, World!"
      ...> end
      "<span>Hello, World!</span>"
  """
  defmacro render(content) do
    quote do
      import HtmlParty.Tag
      unquote(content) |> html_to_string
    end
  end

  @doc """
  Concatenates two blocks of HTML togeather.
  """
  def concat(left, right) do
    [left, right]
  end

  @doc """
  Alias for `HtmlParty.concat`.
  """
  def left <> right do
    [left, right]
  end
end
