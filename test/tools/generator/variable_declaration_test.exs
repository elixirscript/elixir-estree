defmodule ESTree.Tools.Generator.VariableDeclaration.Test do
  use ShouldI

  alias ESTree.Tools.{Builder, Generator}

  should "emit var declaration" do
    ast = Builder.variable_declaration([])

    assert Generator.generate(ast) == "var ;"
  end

  should "emit let declaration" do
    ast = Builder.variable_declaration([], :let)

    assert Generator.generate(ast) == "let ;"
  end

  should "emit const declaration" do
    ast = Builder.variable_declaration([], :const)

    assert Generator.generate(ast) == "const ;"
  end

  should "add variable declarator" do
    ast = Builder.variable_declaration([
      Builder.variable_declarator(Builder.identifier(:a))
    ])

    assert Generator.generate(ast) == "var a;"
  end

  should "add variable declarators with corresponding inits" do
    ast = Builder.variable_declaration([
      Builder.variable_declarator(Builder.identifier(:a), Builder.literal(1)),
      Builder.variable_declarator(Builder.identifier(:b)),
      Builder.variable_declarator(
        Builder.identifier(:c),
        Builder.binary_expression(
          :+,
          Builder.identifier(:a),
          Builder.literal(2)
        )
      )
    ])

    assert Generator.generate(ast) == "var a = 1, b, c = a + 2;"
  end

end
