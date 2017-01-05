defmodule ESTree.Tools.Generator.IfStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert if without else" do
    ast = Builder.if_statement(
      Builder.identifier(:test),
      Builder.block_statement([])
    )

    assert_gen ast, "if (test) {}"
    assert_gen ast, "if(test){}", beauty: false
  end

  should "convert if with else" do
    ast = Builder.if_statement(
      Builder.identifier(:test),
      Builder.block_statement([]),
      Builder.block_statement([])
    )

    assert_gen ast, "if (test) {} else {}"
    assert_gen ast, "if(test){}else{}", beauty: false
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

    assert_gen ast, "if (test) {} else if (test) {} else {}"
    assert_gen ast, "if(test){}else if(test){}else{}", beauty: false
  end

  should "convert if statement with short syntax" do
    ast = Builder.if_statement(
      Builder.identifier(:test),
      Builder.return_statement(Builder.literal(1)),
      Builder.if_statement(
        Builder.identifier(:test2),
        Builder.return_statement(Builder.literal(2)),
        Builder.return_statement(Builder.literal(3))
      )
    )

    assert_gen ast, "if (test)\n    return 1;\nelse if (test2)\n    return 2;\nelse\n    return 3;"
    assert_gen ast, "if(test)return 1;else if(test2)return 2;else return 3;", beauty: false
  end
end
