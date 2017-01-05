defmodule ESTree.Tools.Generator.Assignment.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert assignment expression" do
    ast = Builder.assignment_expression(
      :=,
      Builder.identifier(:a),
      Builder.literal(0)
    )

    assert_gen ast, "a = 0"
    assert_gen ast, "a=0", beauty: false
  end
end
