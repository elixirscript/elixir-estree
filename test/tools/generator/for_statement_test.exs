defmodule ESTree.Tools.Generator.ForStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert for statement empty" do
    ast = Builder.for_statement(
      nil,
      nil,
      nil,
      Builder.block_statement([])
    )

    assert_gen ast, "for (; ; ) {}"
    assert_gen ast, "for(;;){}", beauty: false
  end

  should "convert for statement" do
    ast = Builder.for_statement(
      Builder.variable_declaration([
        Builder.variable_declarator(Builder.identifier(:i), Builder.literal(0))
      ]),
      Builder.binary_expression(
        :<,
        Builder.identifier(:i),
        Builder.identifier(:length)
      ),
      Builder.unary_expression(
        :++,
        false,
        Builder.identifier(:i)
      ),
      Builder.block_statement([])
    )

    assert_gen ast, "for (var i = 0; i < length; i++) {}"
    assert_gen ast, "for(var i=0;i<length;i++){}", beauty: false
  end
end
