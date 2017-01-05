defmodule ESTree.Tools.Generator.ForOfStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert for of statement" do
    ast = Builder.for_of_statement(
      Builder.variable_declaration([
        Builder.variable_declarator(Builder.identifier(:a))
      ]),
      Builder.identifier(:b),
      Builder.block_statement([])
    )

    assert_gen ast, "for (var a of b) {}"
    assert_gen ast, "for(var a of b){}", beauty: false
  end
end
