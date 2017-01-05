defmodule ESTree.Tools.Generator.BlockStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert basic function declaration" do
    ast = Builder.function_declaration(
      Builder.identifier(:hello),
      [],
      [],
      Builder.block_statement([
        Builder.variable_declaration([
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
        ]),
      ]),
      false,
      false
    )

    str = """
function hello() {
    var a = 1,
        b,
        c = a + 2;
}
"""

    assert_gen ast, String.trim(str)
    assert_gen ast, "function hello(){var a=1,b,c=a+2;}", beauty: false
  end
end
