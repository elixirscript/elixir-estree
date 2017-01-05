defmodule ESTree.Tools.Generator.SwitchStatement.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert switch statement" do
    ast = Builder.switch_statement(
      Builder.identifier(:test),
      [
        Builder.switch_case(
          Builder.identifier(:b),
          [Builder.break_statement()]
        ),
        Builder.switch_case(
          Builder.literal("c"),
          [Builder.break_statement()]
        ),
        Builder.switch_case(
          Builder.literal(1),
          [Builder.break_statement()]
        ),
        Builder.switch_case(
          nil,
          [Builder.break_statement()]
        )
      ]
    )

    str = """
switch (test) {
case b:
    break;

case 'c':
    break;

case 1:
    break;

default:
    break;
}
"""

    assert_gen ast, String.trim(str)
    assert_gen ast, "switch(test){case b:break;case 'c':break;case 1:break;default:break;}", beauty: false
  end
end
