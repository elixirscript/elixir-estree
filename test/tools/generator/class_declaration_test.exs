defmodule ESTree.Tools.Generator.ClassDeclaration.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert class declaration" do
    ast = Builder.class_declaration(
      Builder.identifier(:X),
      Builder.class_body([])
    )

    assert_gen ast, "class X {}"
    assert_gen ast, "class X{}", beauty: false
  end

  should "convert class declaration when it extends identifier" do
    ast = Builder.class_declaration(
      Builder.identifier(:X),
      Builder.class_body([]),
      Builder.identifier(:Y)
    )

    assert_gen ast, "class X extends Y {}"
    assert_gen ast, "class X extends Y{}", beauty: false
  end

  should "convert class declaration when it extends class declaration" do
    ast = Builder.class_declaration(
      Builder.identifier(:X),
      Builder.class_body([]),
      Builder.class_declaration(
        Builder.identifier(:Y),
        Builder.class_body([])
      )
    )

    assert_gen ast, "class X extends class Y {} {}"
    assert_gen ast, "class X extends class Y{}{}", beauty: false
  end

  should "convert class declaration when it extends class expression" do
    ast = Builder.class_declaration(
      Builder.identifier(:X),
      Builder.class_body([]),
      Builder.class_expression(
        Builder.class_body([])
      )
    )

    assert_gen ast, "class X extends class {} {}"
    assert_gen ast, "class X extends class{}{}", beauty: false
  end
end
