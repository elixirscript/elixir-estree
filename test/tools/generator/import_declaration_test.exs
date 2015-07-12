defmodule ESTree.Tools.Generator.ImportDeclaration.Test do
  use ShouldI
  alias ESTree.Tools.Builder
  alias ESTree.Tools.Generator

  should "convert import declaration with one specifier" do
    ast = Builder.import_declaration([
      Builder.import_specifier(
        Builder.identifier(:test),
        Builder.identifier(:test)
      )],
      Builder.literal(:test)
    )

    assert Generator.generate(ast) == "import { test } from 'test';"  
  end

  should "convert import declaration with one specifier with an alias" do
    ast = Builder.import_declaration([
      Builder.import_specifier(
        Builder.identifier(:test),
        Builder.identifier(:test1)
      )],
      Builder.literal(:test)
    )

    assert Generator.generate(ast) == "import { test as test1 } from 'test';"  
  end

  should "convert import declaration with more than one specifier" do
    ast = Builder.import_declaration(
      [
        Builder.import_specifier(
          Builder.identifier(:top),
          Builder.identifier(:top)
        ),
        Builder.import_specifier(
          Builder.identifier(:test),
          Builder.identifier(:test1)
        )
      ],
      Builder.literal(:test)
    )

    assert Generator.generate(ast) == "import { top, test as test1 } from 'test';"  
  end


  should "convert import declaration with one default specifier" do
    ast = Builder.import_declaration([
      Builder.import_default_specifier(
        Builder.identifier(:test),
        Builder.identifier(:test)
      )],
      Builder.literal(:test)
    )

    assert Generator.generate(ast) == "import test from 'test';"  
  end

  should "convert import declaration with a namespace specifier" do
    ast = Builder.import_declaration([
      Builder.import_namespace_specifier(
        Builder.identifier(:test)
      )],
      Builder.literal(:test)
    )

    assert Generator.generate(ast) == "import * as test from 'test';"  
  end

end