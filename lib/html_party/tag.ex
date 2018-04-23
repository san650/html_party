defmodule HtmlParty.Tag do
  import Phoenix.HTML.Tag, only: [
    content_tag: 3,
  ]

  @content_tags [
    :a,
    :div,
    :li,
    :span,
    :strong,
    :ul,
  ]

  for tag <- @content_tags do
    def unquote(tag)(attrs \\ [], content)
    def unquote(tag)(attrs, do: content) when is_list(attrs) do
      content_tag(unquote(tag), attrs, do: [content])
    end
    def unquote(tag)(attrs, content) when not is_list(content) do
      content_tag(unquote(tag), attrs, do: [content])
    end
    def unquote(tag)(attrs, content) do
      content_tag(unquote(tag), attrs, do: [content])
    end
  end

  def html_to_string(do: content) do
    html_to_string(content)
  end

  def html_to_string(content) do
    content
    |> Phoenix.HTML.html_escape
    |> Phoenix.HTML.safe_to_string
  end
end
