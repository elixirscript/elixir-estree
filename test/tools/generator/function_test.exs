defmodule ESTree.Tools.Generator.Function.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert basic function declaration" do
    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [],
      [],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "function hello() {}"
    assert_gen ast, "function hello(){}", beauty: false
  end

  should "convert basic function declaration generator" do
    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [],
      [],
      Builder.block_statement([
        Builder.return_statement(
          Builder.yield_expression(
            Builder.call_expression(
              Builder.identifier(:x),
              []
            )
          )
        )
      ]),
      true,
      false
    )

    assert_gen ast, "function* hello() {\n    return yield x();\n}"
    assert_gen ast, "function*hello(){return yield x();}", beauty: false
  end

  should "convert basic async function declaration" do
    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [],
      [],
      Builder.block_statement([
        Builder.return_statement(
          Builder.await_expression(
            Builder.call_expression(
              Builder.identifier(:x),
              []
            )
          )
        )
      ]),
      false,
      false,
      true
    )

    assert_gen ast, "async function hello() {\n    return await x();\n}"
    assert_gen ast, "async function hello(){return await x();}", beauty: false
  end

  should "convert function declaration with params" do
    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [Builder.identifier(:one)],
      [],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "function hello(one) {}"
    assert_gen ast, "function hello(one){}", beauty: false

    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [Builder.identifier(:one), Builder.identifier(:two)],
      [],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "function hello(one, two) {}"
    assert_gen ast, "function hello(one,two){}", beauty: false
  end

  should "convert function declaration with default values" do
    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [Builder.identifier(:one), Builder.identifier(:two)],
      [nil, Builder.literal(1)],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "function hello(one, two = 1) {}"
    assert_gen ast, "function hello(one,two=1){}", beauty: false
  end

  should "convert basic function expression" do
    ast = Builder.function_expression(
      [],
      [],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "function() {}"
    assert_gen ast, "function(){}", beauty: false
  end

  should "convert basic function expression generator" do
    ast = Builder.function_expression(
      [],
      [],
      Builder.block_statement([]),
      true,
      false
    )

    assert_gen ast, "function*() {}"
    assert_gen ast, "function*(){}", beauty: false
  end

  should "convert basic async function expression" do
    ast = Builder.function_expression(
      [],
      [],
      Builder.block_statement([
        Builder.return_statement(
          Builder.await_expression(
            Builder.call_expression(
              Builder.identifier(:x),
              []
            )
          )
        )
      ]),
      false,
      false,
      true
    )

    assert_gen ast, "async function() {\n    return await x();\n}"
    assert_gen ast, "async function(){return await x();}", beauty: false
  end

  should "convert function expression with params" do
    ast = Builder.function_expression(
      [Builder.identifier(:one)],
      [],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "function(one) {}"
    assert_gen ast, "function(one){}", beauty: false

    ast = Builder.function_expression(
      [Builder.identifier(:one), Builder.identifier(:two)],
      [],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "function(one, two) {}"
    assert_gen ast, "function(one,two){}", beauty: false
  end

  should "convert function expression with default values" do
    ast = Builder.function_expression(
      [Builder.identifier(:one), Builder.identifier(:two)],
      [nil, Builder.literal(1)],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "function(one, two = 1) {}"
    assert_gen ast, "function(one,two=1){}", beauty: false
  end
end
