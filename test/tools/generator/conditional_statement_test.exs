defmodule ESTree.Tools.Generator.ConditionalStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert conditional statement" do
    ast = Builder.conditional_statement(
      Builder.identifier(:test),
      Builder.identifier(:alternate),
      Builder.identifier(:consequent)
    )

    assert_gen ast, "test ? consequent : alternate"
    assert_gen ast, "test?consequent:alternate", beauty: false
  end

  should "convert conditional statement precedence" do
    ast = Builder.conditional_statement(
      Builder.assignment_expression(
        :=,
        Builder.identifier(:test),
        Builder.literal(1)
      ),
      Builder.identifier(:alternate),
      Builder.identifier(:consequent)
    )

    assert_gen ast, "(test = 1) ? consequent : alternate"
    assert_gen ast, "(test=1)?consequent:alternate", beauty: false
  end
end
