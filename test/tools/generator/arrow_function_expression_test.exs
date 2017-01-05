defmodule ESTree.Tools.Generator.ArrowFunctionExpression.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert basic arrow function" do
    ast = Builder.arrow_function_expression(
      [],
      [],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "() => {}"
    assert_gen ast, "()=>{}", beauty: false
  end

  should "convert basic arrow function returns object" do
    ast = Builder.arrow_function_expression(
      [],
      [],
      Builder.object_expression([]),
      false,
      false
    )

    assert_gen ast, "() => ({})"
    assert_gen ast, "()=>({})", beauty: false
  end

  should "convert basic arrow function expression generator" do
    ast = Builder.arrow_function_expression(
      [],
      [],
      Builder.block_statement([]),
      true,
      false
    )

    assert_gen ast, "()* => {}"
    assert_gen ast, "()*=>{}", beauty: false
  end

  should "convert arrow function with params" do
    ast = Builder.arrow_function_expression(
      [Builder.identifier(:one)],
      [],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "(one) => {}"
    assert_gen ast, "one=>{}", beauty: false

    ast = Builder.arrow_function_expression(
      [Builder.identifier(:one), Builder.identifier(:two)],
      [],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "(one, two) => {}"
    assert_gen ast, "(one,two)=>{}", beauty: false
  end

  should "convert arrow function with default values" do
    ast = Builder.arrow_function_expression(
      [Builder.identifier(:one), Builder.identifier(:two)],
      [nil, Builder.literal(1)],
      Builder.block_statement([]),
      false,
      false
    )

    assert_gen ast, "(one, two = 1) => {}"
    assert_gen ast, "(one,two=1)=>{}", beauty: false
  end
end
