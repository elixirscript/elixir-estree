defmodule ESTree.Tools.Generator.VariableDeclaration.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "emit var declaration" do
    ast = Builder.variable_declaration([])

    assert_gen ast, "var ;"
    assert_gen ast, "var ;", beauty: false
  end

  should "emit let declaration" do
    ast = Builder.variable_declaration([], :let)

    assert_gen ast, "let ;"
    assert_gen ast, "let ;", beauty: false
  end

  should "emit const declaration" do
    ast = Builder.variable_declaration([], :const)

    assert_gen ast, "const ;"
    assert_gen ast, "const ;", beauty: false
  end

  should "add variable declarator" do
    ast = Builder.variable_declaration([
      Builder.variable_declarator(Builder.identifier(:a))
    ])

    assert_gen ast, "var a;"
    assert_gen ast, "var a;", beauty: false
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

    assert_gen ast, "var a = 1,\n    b,\n    c = a + 2;"
    assert_gen ast, "var a=1,b,c=a+2;", beauty: false
  end
end
