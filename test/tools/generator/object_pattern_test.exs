defmodule ESTree.Generator.ObjectPattern.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert object pattern" do
    ast = Builder.object_pattern([
      Builder.property(
        Builder.identifier(:i),
        nil,
        :init,
        true
      ),
      Builder.property(
        Builder.identifier(:j),
        Builder.identifier(:k)
      )
    ])

    assert_gen ast, "{i, j: k}"
    assert_gen ast, "{i,j:k}", beauty: false

    ast = Builder.object_pattern([
      Builder.property(
        Builder.identifier(:a),
        Builder.array_pattern([
          Builder.identifier(:b),
          Builder.object_pattern([
            Builder.property(
              Builder.identifier(:c),
              nil,
              :init,
              true
            )
          ])
        ])
      )
    ])

    assert_gen ast, "{a: [b, {c}]}"
    assert_gen ast, "{a:[b,{c}]}", beauty: false

    ast = Builder.object_pattern([
      Builder.property(
        Builder.identifier(:g),
        Builder.assignment_expression(
          :=,
          Builder.identifier(:h),
          Builder.literal(1)
        )
      )
    ])

    assert_gen ast, "{g: h = 1}"
  end
end
