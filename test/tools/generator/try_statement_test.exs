defmodule ESTree.Tools.Generator.TryStatement.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator

  should "convert try with catch" do
    ast = Builder.try_statement(
      Builder.block_statement([]),
      Builder.catch_clause(
        Builder.identifier(:e),
        Builder.block_statement([])
      )
    )
    
    assert Generator.generate(ast) == "try{}catch(e) {}"
  end

  should "convert try with finally" do
    ast = Builder.try_statement(
      Builder.block_statement([]),
      nil,
      Builder.block_statement([])
    )
    
    assert Generator.generate(ast) == "try{}finally{}"
  end

  should "convert try catch finally" do
    ast = Builder.try_statement(
      Builder.block_statement([]),
      Builder.catch_clause(
        Builder.identifier(:e),
        Builder.block_statement([])
      ),
      Builder.block_statement([])
    )
    
    assert Generator.generate(ast) == "try{}catch(e) {}finally{}"
  end
end
