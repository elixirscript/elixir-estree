defmodule ESTree.Tools.Generator.ThrowStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert throw statement" do
    ast = Builder.throw_statement(
      Builder.new_expression(
        Builder.identifier(:Error),
        [Builder.literal("error")]
      )
    )

    assert_gen ast, "throw new Error('error');"
    assert_gen ast, "throw new Error('error');", beauty: false
  end
end
