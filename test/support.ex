defmodule ESTree.Test.Support do
  use ShouldI

  alias ESTree.Tools.Generator

  defmacro assert_gen(ast, str, opts \\ []) do
    opts = Keyword.merge([beauty: true], opts)
    beauty = Keyword.get(opts, :beauty)

    quote do
      assert Generator.generate(unquote(ast), unquote(beauty)) == unquote(str)
    end
  end
end
