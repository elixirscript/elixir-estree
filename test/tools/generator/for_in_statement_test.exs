defmodule ESTree.Tools.Generator.ForInStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert for in statement" do
    ast = Builder.for_in_statement(
      Builder.variable_declaration([
        Builder.variable_declarator(Builder.identifier(:a))
      ]),
      Builder.identifier(:b),
      Builder.block_statement([])
    )

    assert_gen ast, "for (var a in b) {}"
    assert_gen ast, "for(var a in b){}", beauty: false
  end
end
