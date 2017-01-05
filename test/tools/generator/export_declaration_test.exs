defmodule ESTree.Tools.Generator.ExportDeclaration.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert export all declaration" do
    ast = Builder.export_all_declaration(Builder.literal(:test))

    assert_gen ast, "export * from 'test';"
    assert_gen ast, "export*from'test';", beauty: false
  end
end
