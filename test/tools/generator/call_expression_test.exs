defmodule ESTree.Tools.Generator.CallExpression.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert call expression when arguments is empty" do
    ast = Builder.call_expression(Builder.identifier(:x), []);

    assert_gen ast, "x()"
    assert_gen ast, "x()", beauty: false
  end

  should "convert call expression with one argument" do
    ast = Builder.call_expression(
      Builder.identifier(:x),
      [
        Builder.identifier(:a)
      ]
    );

    assert_gen ast, "x(a)"
    assert_gen ast, "x(a)", beauty: false
  end

  should "convert call expression with spread" do
    ast = Builder.call_expression(
      Builder.identifier(:x),
      [
        Builder.spread_element(Builder.identifier(:a))
      ]
    );

    assert_gen ast, "x(...a)"
    assert_gen ast, "x(...a)", beauty: false
  end

  should "convert call expression with arguments" do
    ast = Builder.call_expression(
      Builder.identifier(:x),
      [
        Builder.identifier(:a),
        Builder.identifier(:b)
      ]
    );

    assert_gen ast, "x(a, b)"
    assert_gen ast, "x(a,b)", beauty: false
  end

  should "convert call expression with arguments and spread" do
    ast = Builder.call_expression(
      Builder.identifier(:x),
      [
        Builder.identifier(:a),
        Builder.identifier(:b),
        Builder.spread_element(Builder.identifier(:c))
      ]
    );

    assert_gen ast, "x(a, b, ...c)"
    assert_gen ast, "x(a,b,...c)", beauty: false
  end

  should "convert call expression when callee is member expression" do
    ast = Builder.call_expression(
      Builder.member_expression(
        Builder.identifier(:x),
        Builder.identifier(:y)
      ),
      []
    );

    assert_gen ast, "x.y()"
    assert_gen ast, "x.y()", beauty: false
  end

  should "convert call expression when callee is binary expression" do
    ast = Builder.call_expression(
      Builder.member_expression(
        Builder.binary_expression(
          :+,
          Builder.identifier(:a),
          Builder.identifier(:b)
        ),
        Builder.identifier(:x)
      ),
      []
    );

    assert_gen ast, "(a + b).x()"
    assert_gen ast, "(a+b).x()", beauty: false
  end

  should "convert call expression with one argument that is an await" do
    ast = Builder.call_expression(
      Builder.identifier(:x),
      [
        Builder.await_expression(
          Builder.identifier(:a)
        )
      ]
    );

    assert_gen ast, "x((await a))"
    assert_gen ast, "x((await a))", beauty: false
  end

  should "convert call expression with one argument that is a yield" do
    ast = Builder.call_expression(
      Builder.identifier(:x),
      [
        Builder.yield_expression(
          Builder.identifier(:a)
        )
      ]
    );

    assert_gen ast, "x((yield a))"
    assert_gen ast, "x((yield a))", beauty: false
  end
end
