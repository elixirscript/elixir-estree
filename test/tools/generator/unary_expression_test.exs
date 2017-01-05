defmodule ESTree.Generator.UnaryExpression.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert unary expression !true" do
    ast = Builder.unary_expression(
      :!,
      true,
      Builder.literal(true)
    )

    assert_gen ast, "!true"
    assert_gen ast, "!true", beauty: false
  end

  should "convert unary expression !false" do
    ast = Builder.unary_expression(
      :!,
      true,
      Builder.literal(false)
    )

    assert_gen ast, "!false"
    assert_gen ast, "!false", beauty: false
  end

  should "convert unary expression !typeof" do
    ast = Builder.unary_expression(
      :!,
      true,
      Builder.unary_expression(
        :typeof,
        true,
        Builder.identifier(:x)
      )
    )

    assert_gen ast, "!typeof x"
    assert_gen ast, "!typeof x", beauty: false
  end

  should "convert unary expression ! and typeof with binary expression" do
    ast = Builder.unary_expression(
      :!,
      true,
      Builder.binary_expression(
        :===,
        Builder.unary_expression(
          :typeof,
          true,
          Builder.identifier(:x)
        ),
        Builder.literal("boolean")
      )
    )

    assert_gen ast, "!(typeof x === 'boolean')"
    assert_gen ast, "!(typeof x==='boolean')", beauty: false
  end

  should "convert unary expression delete" do
    ast = Builder.unary_expression(
      :delete,
      true,
      Builder.identifier(:a)
    )

    assert_gen ast, "delete a"
    assert_gen ast, "delete a", beauty: false
  end

  should "convert unary expression void" do
    ast = Builder.unary_expression(
      :void,
      true,
      Builder.identifier(:a)
    )

    assert_gen ast, "void a"
    assert_gen ast, "void a", beauty: false
  end
end
