defmodule ESTree.Tools.Generator.ExportDeclaration.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator

  should "convert export named declaration with a declaration" do
    ast = Builder.export_named_declaration(
      Builder.identifier(:test)
    )

    assert Generator.generate(ast) == "export test;"  
  end

  should "convert export named declaration with one specifier" do
    ast = Builder.export_named_declaration(nil, [
      Builder.export_specifier(
        Builder.identifier(:test),
        Builder.identifier(:test)
      )]
    )

    assert Generator.generate(ast) == "export { test };"  
  end

  should "convert export named declaration with one specifier with an alias" do
    ast = Builder.export_named_declaration(nil, [
      Builder.export_specifier(
        Builder.identifier(:test),
        Builder.identifier(:test1)
      )]
    )

    assert Generator.generate(ast) == "export { test as test1 };"  
  end

  should "convert export declaration with more than one specifier" do
    ast = Builder.export_named_declaration(nil,
      [
        Builder.export_specifier(
          Builder.identifier(:top),
          Builder.identifier(:top)
        ),
        Builder.export_specifier(
          Builder.identifier(:test),
          Builder.identifier(:test1)
        )
      ],
      Builder.literal(:test)
    )

    assert Generator.generate(ast) == "export { top, test as test1 } from 'test';"  
  end


  should "convert export all declaration" do
    ast = Builder.export_all_declaration(Builder.literal(:test))

    assert Generator.generate(ast) == "export * from 'test';"  
  end

end