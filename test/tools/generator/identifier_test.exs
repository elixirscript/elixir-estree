defmodule ESTree.Tools.Generator.Identifier.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert identifiers (binary)" do
    ast = Builder.identifier("hello")

    assert_gen ast, "hello"
    assert_gen ast, "hello", beauty: false
  end

  should "convert identifiers (atom)" do
    ast = Builder.identifier(:hello)

    assert_gen ast, "hello"
    assert_gen ast, "hello", beauty: false
  end
end
