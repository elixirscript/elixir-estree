defmodule ESTree.Tools.Generator.WhileStatement.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator


  should "convert while" do
    ast = Builder.while_statement(
      Builder.identifier(:test),
      Builder.block_statement([])
    )
    assert Generator.generate(ast) == "while(test) {}"  
  end

  should "convert do while" do
    ast = Builder.do_while_statement(
      Builder.block_statement([]),
      Builder.identifier(:test)
    )
    assert Generator.generate(ast) == "do {} while(test)"  
  end

end
