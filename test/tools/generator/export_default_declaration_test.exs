defmodule ESTree.Tools.Generator.ExportDefaultDeclaration.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert export default declaration with function declaration" do
    ast = Builder.export_default_declaration(
      Builder.function_declaration(
        Builder.identifier(:x),
        [],
        [],
        Builder.block_statement([])
      )
    )

    assert_gen ast, "export default function x() {}"
    assert_gen ast, "export default function x(){}", beauty: false
  end

  should "convert export default declaration with function expression" do
    ast = Builder.export_default_declaration(
      Builder.function_expression(
        [],
        [],
        Builder.block_statement([])
      )
    )

    assert_gen ast, "export default function() {};"
    assert_gen ast, "export default function(){};", beauty: false
  end

  should "convert export default declaration with function declaration generator" do
    ast = Builder.export_default_declaration(
      Builder.function_declaration(
        Builder.identifier(:x),
        [],
        [],
        Builder.block_statement([]),
        true
      )
    )

    assert_gen ast, "export default function* x() {}"
    assert_gen ast, "export default function*x(){}", beauty: false
  end

  should "convert export default declaration with function expression generator" do
    ast = Builder.export_default_declaration(
      Builder.function_expression(
        [],
        [],
        Builder.block_statement([]),
        true
      )
    )

    assert_gen ast, "export default function*() {};"
    assert_gen ast, "export default function*(){};", beauty: false
  end

  should "convert export default declaration with class declaration" do
    ast = Builder.export_default_declaration(
      Builder.class_declaration(
        Builder.identifier(:y),
        Builder.class_body([])
      )
    )

    assert_gen ast, "export default class y {}"
    assert_gen ast, "export default class y{}", beauty: false
  end

  should "convert export default declaration with class declaration extends" do
    ast = Builder.export_default_declaration(
      Builder.class_declaration(
        Builder.identifier(:y),
        Builder.class_body([]),
        Builder.identifier(:z)
      )
    )

    assert_gen ast, "export default class y extends z {}"
    assert_gen ast, "export default class y extends z{}", beauty: false
  end

  should "convert export default declaration with class expression" do
    ast = Builder.export_default_declaration(
      Builder.class_expression(
        Builder.class_body([])
      )
    )

    assert_gen ast, "export default class {};"
    assert_gen ast, "export default class{};", beauty: false
  end

  should "convert export default declaration with assignment expression" do
    ast = Builder.export_default_declaration(
      Builder.assignment_expression(
        :=,
        Builder.identifier(:x),
        Builder.literal(0)
      )
    )

    assert_gen ast, "export default x = 0;"
    assert_gen ast, "export default x=0;", beauty: false
  end

  should "convert export default declaration with literal" do
    ast = Builder.export_default_declaration(
      Builder.literal(0)
    )

    assert_gen ast, "export default 0;"
    assert_gen ast, "export default 0;", beauty: false
  end

  should "convert export default declaration with sequence expression" do
    ast = Builder.export_default_declaration(
      Builder.sequence_expression([
        Builder.literal(0),
        Builder.literal(1)
      ])
    )

    assert_gen ast, "export default (0, 1);"
    assert_gen ast, "export default (0,1);", beauty: false
  end
end
