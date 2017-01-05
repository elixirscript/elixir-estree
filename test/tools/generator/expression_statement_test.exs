defmodule ESTree.Tools.Generator.ExpressionStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert expression statement with class expression" do
    ast = Builder.expression_statement(
      Builder.class_expression(
        Builder.class_body([])
      )
    )

    assert_gen ast, "(class {});"
    assert_gen ast, "(class{});", beauty: false
  end

  should "convert expression statement with function expression" do
    ast = Builder.expression_statement(
      Builder.function_expression(
        [],
        [],
        Builder.block_statement([])
      )
    )

    assert_gen ast, "(function() {});"
    assert_gen ast, "(function(){});", beauty: false
  end

  should "convert expression statement with object expression" do
    ast = Builder.expression_statement(
      Builder.object_expression(
        []
      )
    )

    assert_gen ast, "({});"
    assert_gen ast, "({});", beauty: false
  end

  should "convert expression statement with assignment expression" do
    ast = Builder.expression_statement(
      Builder.assignment_expression(
        :=,
        Builder.object_pattern([]),
        Builder.identifier(:a)
      )
    )

    assert_gen ast, "({} = a);"
    assert_gen ast, "({}=a);", beauty: false
  end
end
