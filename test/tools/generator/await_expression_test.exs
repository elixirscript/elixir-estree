defmodule ESTree.Tools.Generator.AwaitExpression.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert await expression" do
    ast = Builder.await_expression(
      Builder.literal(1)
    )

    assert_gen ast, "await 1"
  end

  should "convert await expression that contains an await" do
    ast = Builder.await_expression(
      Builder.await_expression(
        Builder.literal(1)
      )
    )

    assert_gen ast, "await (await 1)"
  end
end