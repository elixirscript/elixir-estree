defmodule ESTree.Tools.Generator.TryStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert try with catch" do
    ast = Builder.try_statement(
      Builder.block_statement([]),
      Builder.catch_clause(
        Builder.identifier(:e),
        Builder.block_statement([])
      )
    )

    assert_gen ast, "try {} catch (e) {}"
    assert_gen ast, "try{}catch(e){}", beauty: false
  end

  should "convert try with finally" do
    ast = Builder.try_statement(
      Builder.block_statement([]),
      nil,
      Builder.block_statement([])
    )

    assert_gen ast, "try {} finally {}"
    assert_gen ast, "try{}finally{}", beauty: false
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

    assert_gen ast, "try {} catch (e) {} finally {}"
    assert_gen ast, "try{}catch(e){}finally{}", beauty: false
  end
end
