defmodule ESTree.Tools.Generator.ObjectExpression.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator

  should "convert object when properties is nil" do
    ast = Builder.object_expression(nil)
    assert Generator.generate(ast) == "{}" 
  end

  should "convert object when properties is empty" do
    ast = Builder.object_expression([])
    assert Generator.generate(ast) == "{}" 
  end

  should "convert object when properties contains one property" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.identifier(:key),
        Builder.identifier(:value)
      )
    ])
    assert Generator.generate(ast) == "{key: value}" 
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
    assert Generator.generate(ast) == "{key: value, key1: value1}" 
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
    assert Generator.generate(ast) == "{get key() {}, set key(p) {}}" 
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
    assert Generator.generate(ast) == "{key() {}, key(p) {}}" 
  end

  should "convert object when properties contains shorthand properties" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.identifier(:key),
        Builder.identifier(:key),
        :init,
        true)
    ])
    assert Generator.generate(ast) == "{key}" 
  end
  
end
