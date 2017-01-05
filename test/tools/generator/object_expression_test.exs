defmodule ESTree.Tools.Generator.ObjectExpression.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert object when properties is nil" do
    ast = Builder.object_expression(nil)

    assert_gen ast, "{}"
    assert_gen ast, "{}", beauty: false
  end

  should "convert object when properties is empty" do
    ast = Builder.object_expression([])

    assert_gen ast, "{}"
    assert_gen ast, "{}", beauty: false
  end

  should "convert object when properties contains one property" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.identifier(:key),
        Builder.identifier(:value)
      )
    ])

    assert_gen ast, "{\n    key: value\n}"
    assert_gen ast, "{key:value}", beauty: false
  end

  should "convert object when properties contains one property string" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.literal(:key),
        Builder.identifier(:value)
      )
    ])

    assert_gen ast, "{\n    'key': value\n}"
    assert_gen ast, "{'key':value}", beauty: false
  end

  should "convert object when properties contains computed properties" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.identifier(:key),
        Builder.identifier(:value),
        :init,
        false,
        false,
        true
      ),
      Builder.property(
        Builder.literal(:key),
        Builder.identifier(:value),
        :init,
        false,
        false,
        true
      )
    ])

    assert_gen ast, "{\n    [key]: value,\n    ['key']: value\n}"
    assert_gen ast, "{[key]:value,['key']:value}", beauty: false
  end

  should "convert object when properties contains multiple properties" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.identifier(:key),
        Builder.identifier(:value)
      ),
      Builder.property(
        Builder.identifier(:key1),
        Builder.identifier(:value1)
      )
    ])

    assert_gen ast, "{\n    key: value,\n    key1: value1\n}"
    assert_gen ast, "{key:value,key1:value1}", beauty: false
  end


  should "convert object when properties contains getters and setters" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.identifier(:key),
        Builder.function_expression([],[], Builder.block_statement([])),
        :get
      ),
      Builder.property(
        Builder.identifier(:key),
        Builder.function_expression([Builder.identifier(:p)],[], Builder.block_statement([])),
        :set
      ),
    ])

    assert_gen ast, "{\n    get key() {},\n    set key(p) {}\n}"
    assert_gen ast, "{get key(){},set key(p){}}", beauty: false
  end

  should "convert object when properties contains getter and setter methods" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.identifier(:key),
        Builder.function_expression([],[], Builder.block_statement([])),
        :get,
        false,
        true
      ),
      Builder.property(
        Builder.identifier(:key),
        Builder.function_expression([Builder.identifier(:p)],[], Builder.block_statement([])),
        :set,
        false,
        true
      ),
    ])

    assert_gen ast, "{\n    key() {},\n    key(p) {}\n}"
    assert_gen ast, "{key(){},key(p){}}", beauty: false
  end

  should "convert object when properties are methods computed" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.identifier(:key),
        Builder.function_expression([], [], Builder.block_statement([])),
        :init,
        false,
        true,
        true
      ),
      Builder.property(
        Builder.literal(:key),
        Builder.function_expression([], [], Builder.block_statement([])),
        :init,
        false,
        true,
        true
      ),
    ])

    assert_gen ast, "{\n    [key]() {},\n    ['key']() {}\n}"
    assert_gen ast, "{[key](){},['key'](){}}", beauty: false
  end

  should "convert object when properties contains shorthand properties" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.identifier(:key),
        Builder.identifier(:key),
        :init,
        true)
    ])

    assert_gen ast, "{\n    key\n}"
    assert_gen ast, "{key}", beauty: false
  end
end
