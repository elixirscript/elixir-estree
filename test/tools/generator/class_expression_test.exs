defmodule ESTree.Tools.Generator.ClassExpression.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert class expression" do
    ast = Builder.class_expression(
      Builder.class_body([])
    )

    assert_gen ast, "class {}"
    assert_gen ast, "class{}", beauty: false
  end

  should "convert class expression when it extends identifier" do
    ast = Builder.class_expression(
      Builder.class_body([]),
      Builder.identifier(:Y)
    )

    assert_gen ast, "class extends Y {}"
    assert_gen ast, "class extends Y{}", beauty: false
  end

  should "convert class expression when it extends class declaration" do
    ast = Builder.class_expression(
      Builder.class_body([]),
      Builder.class_declaration(
        Builder.identifier(:Y),
        Builder.class_body([])
      )
    )

    assert_gen ast, "class extends class Y {} {}"
    assert_gen ast, "class extends class Y{}{}", beauty: false
  end

  should "convert class expression when it extends class expression" do
    ast = Builder.class_expression(
      Builder.class_body([]),
      Builder.class_expression(
        Builder.class_body([])
      )
    )

    assert_gen ast, "class extends class {} {}"
    assert_gen ast, "class extends class{}{}", beauty: false
  end
end
