defmodule ESTree.Tools.Generator.IfStatement.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator

  should "convert if without else" do
    ast = Builder.if_statement(
      Builder.identifier(:test),
      Builder.block_statement([])
    )
    assert Generator.generate(ast) == "if(test) {}"  
  end

  should "convert if with else" do
    ast = Builder.if_statement(
      Builder.identifier(:test),
      Builder.block_statement([]),
      Builder.block_statement([])
    )
    assert Generator.generate(ast) == "if(test) {} else {}"  
  end

  should "convert if with else if" do
    ast = Builder.if_statement(
      Builder.identifier(:test),
      Builder.block_statement([]),
      Builder.if_statement(
        Builder.identifier(:test),
        Builder.block_statement([]),
        Builder.block_statement([])
      )
    )
    assert Generator.generate(ast) == "if(test) {} else if(test) {} else {}"  
  end

end
