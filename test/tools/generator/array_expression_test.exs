defmodule ESTree.Tools.Generator.ArrayExpression.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert array when elements is nil" do
    assert_gen Builder.array_expression(nil), "[]"
  end

  should "convert array when elements is empty" do
    assert_gen Builder.array_expression([]), "[]"
  end

  should "convert array when elements contains one element" do
    assert_gen Builder.array_expression([
      Builder.literal(1)
    ]), "[1]"
  end

  should "convert array when elements contains multiple elements" do
    ast = Builder.array_expression([
      Builder.literal(1),
      Builder.identifier(:a),
      Builder.spread_element(Builder.identifier(:b))
    ])

    assert_gen ast, "[1, a, ...b]"
    assert_gen ast, "[1,a,...b]", beauty: false
  end
end
