defmodule ESTree.Tools.Generator.Identifier.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator

  should "convert identifiers" do
    ast = Builder.identifier("hello")
    assert Generator.generate(ast) == "hello"

    ast = Builder.identifier(:hello)
    assert Generator.generate(ast) == "hello"   
  end
end
