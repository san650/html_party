defmodule HtmlParty.TagTest do
  use ExUnit.Case
  doctest HtmlParty.Tag

  describe "content tags" do
    test "only with content" do
      expected = "<a>Hello, World!</a>"
      actual = "Hello, World!"
               |> HtmlParty.Tag.a
               |> Phoenix.HTML.safe_to_string

      assert actual == expected
    end
  end
end
