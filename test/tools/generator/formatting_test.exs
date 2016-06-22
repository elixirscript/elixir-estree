defmodule ESTree.Tools.Generator.Formatting.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator

  should "format objects" do
    ast = Builder.object_expression([
      Builder.property(
        Builder.identifier(:key),
        Builder.identifier(:value)
      ),
      Builder.property(
        Builder.identifier(:key),
        Builder.identifier(:value)
      )
    ])
    assert Generator.generate(ast, 0) <> "\n" ==
"""
{
  key: value,
  key: value
}
"""
  end

  should "format objects in function calls" do
    ast = Builder.call_expression(
      Builder.identifier(:foo),
      [
        Builder.object_expression([
          Builder.property(
            Builder.identifier(:key),
            Builder.identifier(:value)
          ),
          Builder.property(
            Builder.identifier(:key),
            Builder.identifier(:value)
          )
        ])
      ]
    )
    assert Generator.generate(ast, 0) <> "\n" ==
"""
foo({
  key: value,
  key: value
})
"""
  end
end
