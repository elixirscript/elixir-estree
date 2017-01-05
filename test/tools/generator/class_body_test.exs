defmodule ESTree.Tools.Generator.ClassBody.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert class body with method definition constructor" do
    ast = Builder.class_body([
      Builder.method_definition(
        nil,
        Builder.function_expression(
          [],
          [],
          Builder.block_statement([
            Builder.expression_statement(
              Builder.call_expression(
                Builder.super(),
                []
              )
            )
          ])
        ),
        :constructor
      )
    ])

    assert_gen ast, "{\n    constructor() {\n        super();\n    }\n}"
    assert_gen ast, "{constructor(){super();}}", beauty: false
  end

  should "convert class body with method definition" do
    ast = Builder.class_body([
      Builder.method_definition(
        Builder.identifier(:method),
        Builder.function_expression(
          [],
          [],
          Builder.block_statement([])
        )
      )
    ])

    assert_gen ast, "{\n    method() {}\n}"
    assert_gen ast, "{method(){}}", beauty: false
  end

  should "convert class body with method definition getter" do
    ast = Builder.class_body([
      Builder.method_definition(
        Builder.identifier(:property),
        Builder.function_expression(
          [],
          [],
          Builder.block_statement([])
        ),
        :get
      )
    ])

    assert_gen ast, "{\n    get property() {}\n}"
    assert_gen ast, "{get property(){}}", beauty: false
  end

  should "convert class body with method definition setter" do
    ast = Builder.class_body([
      Builder.method_definition(
        Builder.identifier(:property),
        Builder.function_expression(
          [Builder.identifier(:value)],
          [],
          Builder.block_statement([])
        ),
        :set
      )
    ])

    assert_gen ast, "{\n    set property(value) {}\n}"
    assert_gen ast, "{set property(value){}}", beauty: false
  end

  should "convert class body with method definition computed" do
    ast = Builder.class_body([
      Builder.method_definition(
        Builder.member_expression(Builder.identifier(:Symbol), Builder.identifier(:iterator)),
        Builder.function_expression(
          [],
          [],
          Builder.block_statement([])
        ),
        :method,
        true
      )
    ])

    assert_gen ast, "{\n    [Symbol.iterator]() {}\n}"
    assert_gen ast, "{[Symbol.iterator](){}}", beauty: false
  end

  should "convert class body with method definition computed literal" do
    ast = Builder.class_body([
      Builder.method_definition(
        Builder.literal(:method),
        Builder.function_expression(
          [],
          [],
          Builder.block_statement([])
        ),
        :method,
        true
      )
    ])

    assert_gen ast, "{\n    ['method']() {}\n}"
    assert_gen ast, "{['method'](){}}", beauty: false
  end

  should "convert class body with method definition static" do
    ast = Builder.class_body([
      Builder.method_definition(
        Builder.identifier("classMethod"),
        Builder.function_expression(
          [],
          [],
          Builder.block_statement([])
        ),
        :method,
        false,
        true
      )
    ])

    assert_gen ast, "{\n    static classMethod() {}\n}"
    assert_gen ast, "{static classMethod(){}}", beauty: false
  end

  should "convert class body with method definition static getter" do
    ast = Builder.class_body([
      Builder.method_definition(
        Builder.identifier(:property),
        Builder.function_expression(
          [],
          [],
          Builder.block_statement([])
        ),
        :get,
        false,
        true
      )
    ])

    assert_gen ast, "{\n    static get property() {}\n}"
    assert_gen ast, "{static get property(){}}", beauty: false
  end

  should "convert class body with method definition static setter" do
    ast = Builder.class_body([
      Builder.method_definition(
        Builder.identifier(:property),
        Builder.function_expression(
          [Builder.identifier(:value)],
          [],
          Builder.block_statement([])
        ),
        :set,
        false,
        true
      )
    ])

    assert_gen ast, "{\n    static set property(value) {}\n}"
    assert_gen ast, "{static set property(value){}}", beauty: false
  end

  should "convert class body with method definition static computed" do
    ast = Builder.class_body([
      Builder.method_definition(
        Builder.member_expression(Builder.identifier(:Symbol), Builder.identifier(:iterator)),
        Builder.function_expression(
          [],
          [],
          Builder.block_statement([])
        ),
        :method,
        true,
        true
      )
    ])

    assert_gen ast, "{\n    static [Symbol.iterator]() {}\n}"
    assert_gen ast, "{static [Symbol.iterator](){}}", beauty: false
  end

  should "convert class body with method definition static computed literal" do
    ast = Builder.class_body([
      Builder.method_definition(
        Builder.literal(:method),
        Builder.function_expression(
          [],
          [],
          Builder.block_statement([])
        ),
        :method,
        true,
        true
      )
    ])

    assert_gen ast, "{\n    static ['method']() {}\n}"
    assert_gen ast, "{static ['method'](){}}", beauty: false
  end
end
