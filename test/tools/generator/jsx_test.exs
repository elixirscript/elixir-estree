defmodule ESTree.Tools.Generator.JSX.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "handle atom and binary as identifier name" do
    assert_gen Builder.jsx_identifier("Test"), "Test"
    assert_gen Builder.jsx_identifier(:Test), "Test"
  end

  should "handle no closing tag" do
    ast = Builder.jsx_element(
      Builder.jsx_opening_element(
        Builder.jsx_identifier(
          "Test"
        ),
        [],
        true
      )
    )

    assert_gen ast, "<Test />"
    assert_gen ast, "<Test/>", beauty: false
  end

  should "handle closing tag" do
    ast = Builder.jsx_element(
      Builder.jsx_opening_element(
        Builder.jsx_identifier(
          "Test"
        )
      ),
      [],
      Builder.jsx_closing_element(
        Builder.jsx_identifier(
          "Test"
        )
      )
    )

    assert_gen ast, "<Test></Test>"
    assert_gen ast, "<Test></Test>", beauty: false
  end


  should "handle element with attributes" do
    ast = Builder.jsx_element(
      Builder.jsx_opening_element(
        Builder.jsx_identifier("Test"),
        [
          Builder.jsx_attribute(
            Builder.jsx_identifier("className"),
            Builder.literal("test")
          ),
          Builder.jsx_attribute(
            Builder.jsx_identifier("name"),
            Builder.jsx_expression_container(
              Builder.array_expression([
                Builder.literal(1)
              ])
            )
          ),
          Builder.jsx_spread_attribute(
            Builder.array_expression([
              Builder.literal(1)
            ])
          )
        ]
      ),
      [],
      Builder.jsx_closing_element(
        Builder.jsx_identifier(
          "Test"
        )
      )
    )

    assert_gen ast, "<Test className='test' name={[1]} {...[1]}></Test>"
    assert_gen ast, "<Test className='test' name={[1]} {...[1]}></Test>", beauty: false
  end

  should "handle escaped attributes value" do
    ast = fn x ->
      Builder.jsx_element(
        Builder.jsx_opening_element(
          Builder.jsx_identifier("Test"),
          [
            Builder.jsx_attribute(
              Builder.jsx_identifier("className"),
              x
            )
          ]
        ),
        [],
        Builder.jsx_closing_element(
          Builder.jsx_identifier(
            "Test"
          )
        )
      )
    end

    assert_gen ast.(Builder.literal("\\")), "<Test className='\\\\'></Test>"
    assert_gen ast.(Builder.literal("\n")), "<Test className='\\n'></Test>"
    assert_gen ast.(Builder.literal("\r")), "<Test className='\\r'></Test>"
    assert_gen ast.(Builder.literal("\t")), "<Test className='\\t'></Test>"
    assert_gen ast.(Builder.literal("\b")), "<Test className='\\b'></Test>"
    assert_gen ast.(Builder.literal("\f")), "<Test className='\\f'></Test>"
    assert_gen ast.(Builder.literal("\v")), "<Test className='\\v'></Test>"
    assert_gen ast.(Builder.literal("\u2028")), "<Test className='\\u2028'></Test>"
    assert_gen ast.(Builder.literal("\u2029")), "<Test className='\\u2029'></Test>"
    assert_gen ast.(Builder.literal("\ufeff")), "<Test className='\\ufeff'></Test>"
    assert_gen ast.(Builder.literal("'")), "<Test className='\\''></Test>"
  end

  should "handle element with elements inside" do
    ast = Builder.jsx_element(
      Builder.jsx_opening_element(
        Builder.jsx_identifier("Test")
      ),
      [
        Builder.jsx_element(
          Builder.jsx_opening_element(
            Builder.jsx_identifier("div"), [], true
          )
        )
      ],
      Builder.jsx_closing_element(
        Builder.jsx_identifier(
          "Test"
        )
      )
    )

    assert_gen ast, "<Test><div /></Test>"
    assert_gen ast, "<Test><div/></Test>", beauty: false
  end

  should "handle namespaced names" do
    ast = Builder.jsx_element(
      Builder.jsx_opening_element(
        Builder.jsx_namespaced_name(
          Builder.jsx_identifier("Test"),
          Builder.jsx_identifier("xml")
        )
      ),
      [
        Builder.jsx_element(
          Builder.jsx_opening_element(
            Builder.jsx_identifier("div"), [], true
          )
        )
      ],
      Builder.jsx_closing_element(
        Builder.jsx_namespaced_name(
          Builder.jsx_identifier("Test"),
          Builder.jsx_identifier("xml")
        )
      )
    )

    assert_gen ast, "<Test:xml><div /></Test:xml>"
    assert_gen ast, "<Test:xml><div/></Test:xml>", beauty: false
  end

  should "handle member names" do
    ast = Builder.jsx_element(
      Builder.jsx_opening_element(
        Builder.jsx_member_expression(
          Builder.jsx_identifier("Test"),
          Builder.jsx_identifier("xml")
        )
      ),
      [
        Builder.jsx_element(
          Builder.jsx_opening_element(
            Builder.jsx_identifier("div"), [], true
          )
        )
      ],
      Builder.jsx_closing_element(
        Builder.jsx_member_expression(
          Builder.jsx_identifier("Test"),
          Builder.jsx_identifier("xml")
        )
      )
    )

    assert_gen ast, "<Test.xml><div /></Test.xml>"
    assert_gen ast, "<Test.xml><div/></Test.xml>", beauty: false
  end

  should "handle inner text" do
    ast = Builder.jsx_element(
      Builder.jsx_opening_element(
        Builder.jsx_identifier(
          "Test"
        )
      ),
      [
        Builder.literal("counter: "),
        Builder.jsx_expression_container(
          Builder.identifier(:count)
        ),
        Builder.literal("."),
      ],
      Builder.jsx_closing_element(
        Builder.jsx_identifier(
          "Test"
        )
      )
    )

    assert_gen ast, "<Test>counter: {count}.</Test>"
    assert_gen ast, "<Test>counter: {count}.</Test>", beauty: false
  end

  should "handle inner text escape" do
    ast = fn x ->
      Builder.jsx_element(
        Builder.jsx_opening_element(
          Builder.jsx_identifier(
            "Test"
          )
        ),
        [x],
        Builder.jsx_closing_element(
          Builder.jsx_identifier(
            "Test"
          )
        )
      )
    end

    assert_gen ast.(Builder.literal("{")), "<Test>&lcub;</Test>"
    assert_gen ast.(Builder.literal("}")), "<Test>&rcub;</Test>"
    assert_gen ast.(Builder.literal("<")), "<Test>&lt;</Test>"
    assert_gen ast.(Builder.literal(">")), "<Test>&gt;</Test>"
  end
end
