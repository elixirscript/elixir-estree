defmodule ESTree.Tools.Generator.ArrayPattern.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert array pattern when elements is nil" do
    assert_gen Builder.array_pattern(nil), "[]"
  end

  should "convert array pattern when elements is empty" do
    assert_gen Builder.array_pattern([]), "[]"
  end

  should "convert array pattern when elements contains one element" do
    assert_gen Builder.array_pattern([
      Builder.identifier(:a)
    ]), "[a]"
  end

  should "convert array pattern when elements contains multiple elements" do
    ast = Builder.array_pattern([
      Builder.identifier(:a),
      Builder.identifier(:b),
      Builder.spread_element(Builder.identifier(:c))
    ])

    assert_gen ast, "[a, b, ...c]"
    assert_gen ast, "[a,b,...c]", beauty: false
  end
end
