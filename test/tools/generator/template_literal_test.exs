defmodule ESTree.Tools.Generator.TemplateLiteral.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert empty template literal" do
    ast = Builder.template_literal([],[])

    assert_gen ast, "``"
    assert_gen ast, "``", beauty: false
  end

  should "convert template literal with no expressions" do
    ast = Builder.template_literal([
      Builder.template_element("hello ", "hello ", false,
        Builder.source_location(
          nil,
          Builder.position(0, 1),
          Builder.position(0, 5)
        )
      ),
      Builder.template_element("there", "there", true,
        Builder.source_location(
          nil,
          Builder.position(0, 5),
          Builder.position(0, 10)
        )
      )
    ], [])

    assert_gen ast, "`hello there`"
    assert_gen ast, "`hello there`", beauty: false
  end

  should "convert template literal with no quasis" do
    ast = Builder.template_literal(
      [],
      [
        Builder.identifier(:a,
          Builder.source_location(
            nil,
            Builder.position(0, 1),
            Builder.position(0, 2)
          )
        )
      ]
    )

    assert_gen ast, "`${a}`"
    assert_gen ast, "`${a}`", beauty: false
  end


  should "convert template literal with interlaping quasis and expressions" do
    ast = Builder.template_literal([
      Builder.template_element("hello ", "hello ", false,
        Builder.source_location(
          nil,
          Builder.position(0, 1),
          Builder.position(0, 5)
        )
      ),
      Builder.template_element(" there", " there", true,
        Builder.source_location(
          nil,
          Builder.position(0, 6),
          Builder.position(0, 12)
        )
      )
    ], [
      Builder.identifier(:a,
        Builder.source_location(
          nil,
          Builder.position(0, 5),
          Builder.position(0, 6)
        )
      )
    ])

    assert_gen ast, "`hello ${a} there`"
    assert_gen ast, "`hello ${a} there`", beauty: false
  end

  should "convert tagged template expressions" do
    ast = Builder.tagged_template_expression(
      Builder.identifier(:tag),
      Builder.template_literal([
        Builder.template_element("hello ", "hello ", false,
          Builder.source_location(
            nil,
            Builder.position(0, 1),
            Builder.position(0, 5)
          )
        ),
        Builder.template_element(" there", " there", true,
          Builder.source_location(
            nil,
            Builder.position(0, 6),
            Builder.position(0, 12)
          )
        )
      ],[
        Builder.identifier(:a,
          Builder.source_location(
            nil,
            Builder.position(0, 5),
            Builder.position(0, 6)
          )
        )
      ])
    )

    assert_gen ast, "tag `hello ${a} there`"
    assert_gen ast, "tag `hello ${a} there`", beauty: false
  end
end
