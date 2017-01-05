defmodule ESTree.Tools.Generator.WhileStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert while" do
    ast = Builder.while_statement(
      Builder.identifier(:test),
      Builder.block_statement([])
    )

    assert_gen ast, "while (test) {}"
    assert_gen ast, "while(test){}", beauty: false
  end

  should "convert do while" do
    ast = Builder.do_while_statement(
      Builder.block_statement([]),
      Builder.identifier(:test)
    )

    assert_gen ast, "do {} while (test);"
    assert_gen ast, "do{}while(test);", beauty: false
  end
end
