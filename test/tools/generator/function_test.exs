defmodule ESTree.Tools.Generator.Function.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator

  should "convert basic function declaration" do
    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [],
      [],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "function hello(){}" 
  end

  should "convert basic function declaration generator" do
    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [],
      [],
      Builder.block_statement([]),
      true,
      false)

    assert Generator.generate(ast) == "function* hello(){}" 
  end

  should "convert function declaration with params" do
    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [Builder.identifier(:one)],
      [],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "function hello(one){}"

    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [Builder.identifier(:one), Builder.identifier(:two)],
      [],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "function hello(one,two){}" 
  end

  should "convert function declaration with default values" do
    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [Builder.identifier(:one), Builder.identifier(:two)],
      [nil, Builder.literal(1)],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "function hello(one,two = 1){}" 
  end

  should "convert basic function expression" do
    ast = Builder.function_expression(
      [],
      [],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "function(){}" 
  end

  should "convert basic function expression generator" do
    ast = Builder.function_expression(
      [],
      [],
      Builder.block_statement([]),
      true,
      false)

    assert Generator.generate(ast) == "function*(){}" 
  end

  should "convert function expression with params" do
    ast = Builder.function_expression(
      [Builder.identifier(:one)],
      [],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "function(one){}"

    ast = Builder.function_expression(
      [Builder.identifier(:one), Builder.identifier(:two)],
      [],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "function(one,two){}" 
  end

  should "convert function expression with default values" do
    ast = Builder.function_expression(
      [Builder.identifier(:one), Builder.identifier(:two)],
      [nil, Builder.literal(1)],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "function(one,two = 1){}" 
  end

  should "convert basic arrow function" do
    ast = Builder.arrow_function_expression(
      [],
      [],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "() => {}" 
  end

  should "convert basic arrow function expression generator" do
    ast = Builder.arrow_function_expression(
      [],
      [],
      Builder.block_statement([]),
      true,
      false)

    assert Generator.generate(ast) == "()* => {}" 
  end

  should "convert arrow function with params" do
    ast = Builder.arrow_function_expression(
      [Builder.identifier(:one)],
      [],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "(one) => {}"

    ast = Builder.arrow_function_expression(
      [Builder.identifier(:one), Builder.identifier(:two)],
      [],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "(one,two) => {}" 
  end

  should "convert arrow function with default values" do
    ast = Builder.arrow_function_expression(
      [Builder.identifier(:one), Builder.identifier(:two)],
      [nil, Builder.literal(1)],
      Builder.block_statement([]),
      false,
      false)

    assert Generator.generate(ast) == "(one,two = 1) => {}" 
  end
end
