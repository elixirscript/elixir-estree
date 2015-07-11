defmodule ESTree.Tools.Generator.ArrayExpression.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator

  should "convert array when elements is nil" do
    ast = Builder.array_expression(nil)
    assert Generator.generate(ast) == "[]" 
  end

  should "convert array when elements is empty" do
    ast = Builder.array_expression([])
    assert Generator.generate(ast) == "[]" 
  end

  should "convert array when elements contains one element" do
    ast = Builder.array_expression([
      Builder.literal(1)
    ])
    assert Generator.generate(ast) == "[1]" 
  end

  should "convert array when elements contains multiple elements" do
    ast = Builder.array_expression([
      Builder.literal(1),
      Builder.identifier(:a)
    ])
    assert Generator.generate(ast) == "[1, a]" 
  end

end
