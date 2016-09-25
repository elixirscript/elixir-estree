defmodule ESTree.Tools.Generator.JSX.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator 


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

    assert Generator.generate(ast) == "<Test/>"
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

    assert Generator.generate(ast) == "<Test></Test>"
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

    assert Generator.generate(ast) == "<Test className='test' name={[1]} {...[1]}></Test>"
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

    assert Generator.generate(ast) == "<Test><div/></Test>"
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

    assert Generator.generate(ast) == "<Test:xml><div/></Test:xml>"
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

    assert Generator.generate(ast) == "<Test.xml><div/></Test.xml>"
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

    assert Generator.generate(ast) == "<Test>counter: {count}.</Test>"
  end
end
