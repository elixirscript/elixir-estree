defmodule ESTree.Generator.Literal.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator

  should "convert numbers" do
    ast = Builder.literal(1)
    assert Generator.generate(ast) == "1"

    ast = Builder.literal(10)
    assert Generator.generate(ast) == "10"

    ast = Builder.literal(1.012)
    assert Generator.generate(ast) == "1.012"
  end

  should "convert booleans" do
    ast = Builder.literal(true)
    assert Generator.generate(ast) == "true"

    ast = Builder.literal(false)
    assert Generator.generate(ast) == "false"
  end

  should "convert string" do
    ast = Builder.literal("hello")
    assert Generator.generate(ast) == "'hello'"

    ast = Builder.literal("goodbye")
    assert Generator.generate(ast) == "'goodbye'"
  end

  should "convert null" do
    ast = Builder.literal(nil)
    assert Generator.generate(ast) == "null"
  end

  should "convert regex" do
    ast = Builder.literal(%{}, Builder.regex("^abc$", "i"))
    assert Generator.generate(ast) == "/^abc$/i"

    ast = Builder.literal(%{}, Builder.regex("^abc$", ""))
    assert Generator.generate(ast) == "/^abc$/"

    ast = Builder.literal(%{}, Builder.regex("", ""))
    assert Generator.generate(ast) == "//"
  end
  
end
