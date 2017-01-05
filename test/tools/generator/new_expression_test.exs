defmodule ESTree.Tools.Generator.NewExpression.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert new expression when arguments are empty" do
    ast = Builder.new_expression(
      Builder.identifier(:X),
      []
    )

    assert_gen ast, "new X()"
    assert_gen ast, "new X()", beauty: false
  end

  should "convert new expression when argument" do
    ast = Builder.new_expression(
      Builder.identifier(:X),
      [Builder.identifier(:a)]
    )

    assert_gen ast, "new X(a)"
    assert_gen ast, "new X(a)", beauty: false
  end

  should "convert new expression when callee is member expression" do
    ast = Builder.new_expression(
      Builder.member_expression(
        Builder.identifier(:x),
        Builder.identifier(:Y)
      ),
      []
    )

    assert_gen ast, "new x.Y()"
    assert_gen ast, "new x.Y()", beauty: false
  end

  should "convert new expression when callee is call expression" do
    ast = Builder.new_expression(
      Builder.member_expression(
        Builder.call_expression(
          Builder.identifier(:x),
          []
        ),
        Builder.identifier(:Y)
      ),
      []
    )

    assert_gen ast, "new (x().Y)()"
    assert_gen ast, "new (x().Y)()", beauty: false
  end

  should "convert new expression when callee is new expression" do
    ast = Builder.new_expression(
      Builder.new_expression(
        Builder.identifier(:X),
        []
      ),
      []
    )

    assert_gen ast, "new new X()()"
    assert_gen ast, "new new X()()", beauty: false
  end

  should "convert new expression when callee is sequence expression" do
    ast = Builder.new_expression(
      Builder.sequence_expression([
        Builder.identifier(:X),
        Builder.identifier(:Y)
      ]),
      []
    )

    assert_gen ast, "new (X, Y)()"
    assert_gen ast, "new (X,Y)()", beauty: false
  end

  should "convert new expression when callee is conditional statement" do
    ast = Builder.new_expression(
      Builder.conditional_statement(
        Builder.literal(true),
        Builder.identifier(:Y),
        Builder.identifier(:X)
      ),
      []
    )

    assert_gen ast, "new (true ? X : Y)()"
    assert_gen ast, "new (true?X:Y)()", beauty: false
  end
end
