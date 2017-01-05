defmodule ESTree.Generator.BinaryExpression.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert binary expression with correct precedence" do
    ast = Builder.binary_expression(
      :+,
      Builder.literal(1),
      Builder.binary_expression(
        :/,
        Builder.binary_expression(
          :*,
          Builder.literal(2),
          Builder.literal(3)
        ),
        Builder.literal(4)
      )
    )

    assert_gen ast, "1 + 2 * 3 / 4"
    assert_gen ast, "1+2*3/4", beauty: false

    ast = Builder.binary_expression(
      :+,
      Builder.literal(1),
      Builder.binary_expression(
        :*,
        Builder.literal(2),
        Builder.binary_expression(
          :/,
          Builder.literal(3),
          Builder.literal(4)
        )
      )
    )

    assert_gen ast, "1 + 2 * (3 / 4)"
    assert_gen ast, "1+2*(3/4)", beauty: false

    ast = Builder.binary_expression(
      :/,
      Builder.binary_expression(
        :*,
        Builder.binary_expression(
          :+,
          Builder.literal(1),
          Builder.literal(2)
        ),
        Builder.literal(3)
      ),
      Builder.literal(4)
    )

    assert_gen ast, "(1 + 2) * 3 / 4"
    assert_gen ast, "(1+2)*3/4", beauty: false

    ast = Builder.binary_expression(
      :*,
      Builder.binary_expression(
        :+,
        Builder.literal(1),
        Builder.literal(2)
      ),
      Builder.binary_expression(
        :/,
        Builder.literal(3),
        Builder.literal(4)
      )
    )

    assert_gen ast, "(1 + 2) * (3 / 4)"
    assert_gen ast, "(1+2)*(3/4)", beauty: false
  end

  should "convert binary expression in" do
    ast = Builder.binary_expression(
      :in,
      Builder.identifier(:a),
      Builder.identifier(:b)
    )

    assert_gen ast, "(a in b)"
    assert_gen ast, "(a in b)", beauty: false
  end

  should "convert binary expression instanceof" do
    ast = Builder.binary_expression(
      :instanceof,
      Builder.unary_expression(
        :!,
        true,
        Builder.identifier(:x)
      ),
      Builder.identifier(:Number)
    )

    assert_gen ast, "!x instanceof Number"
    assert_gen ast, "!x instanceof Number", beauty: false

    ast = Builder.unary_expression(
      :!,
      true,
      Builder.binary_expression(
        :instanceof,
        Builder.identifier(:x),
        Builder.identifier(:Number)
      )
    )

    assert_gen ast, "!(x instanceof Number)"
    assert_gen ast, "!(x instanceof Number)", beauty: false
  end
end
