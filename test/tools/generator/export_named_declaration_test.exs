defmodule ESTree.Tools.Generator.ExportNamedDeclaration.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert export named declaration with one specifier" do
    ast = Builder.export_named_declaration(nil, [
          Builder.export_specifier(
            Builder.identifier(:test),
            Builder.identifier(:test)
          )]
    )

    assert_gen ast, "export { test };"
    assert_gen ast, "export{test};", beauty: false
  end

  should "convert export named declaration with one specifier with an alias" do
    ast = Builder.export_named_declaration(nil, [
          Builder.export_specifier(
            Builder.identifier(:test),
            Builder.identifier(:test1)
          )]
    )

    assert_gen ast, "export { test as test1 };"
    assert_gen ast, "export{test as test1};", beauty: false
  end

  should "convert export named declaration with more than one specifier" do
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

    assert_gen ast, "export { top, test as test1 } from 'test';"
    assert_gen ast, "export{top,test as test1}from'test';", beauty: false
  end

  should "convert export named declaration with variable declaration" do
    ast = Builder.export_named_declaration(
      Builder.variable_declaration([
        Builder.variable_declarator(Builder.identifier(:a)),
        Builder.variable_declarator(Builder.identifier(:b), Builder.literal(0))
      ])
    )

    assert_gen ast, "export var a,\n    b = 0;"
    assert_gen ast, "export var a,b=0;", beauty: false
  end

  should "convert export named declaration with let variable declaration" do
    ast = Builder.export_named_declaration(
      Builder.variable_declaration([
        Builder.variable_declarator(Builder.identifier(:a)),
        Builder.variable_declarator(Builder.identifier(:b), Builder.literal(0))
      ],
        :let)
    )

    assert_gen ast, "export let a,\n    b = 0;"
    assert_gen ast, "export let a,b=0;", beauty: false
  end

  should "convert export named declaration with const variable declaration" do
    ast = Builder.export_named_declaration(
      Builder.variable_declaration([
        Builder.variable_declarator(Builder.identifier(:a)),
        Builder.variable_declarator(Builder.identifier(:b), Builder.literal(0))
      ],
        :const)
    )

    assert_gen ast, "export const a,\n     b = 0;"
    assert_gen ast, "export const a,b=0;", beauty: false
  end

  should "convert export named declaration with function declaration" do
    ast = Builder.export_named_declaration(
      Builder.function_declaration(
        Builder.identifier(:x),
        [],
        [],
        Builder.block_statement([])
      )
    )

    assert_gen ast, "export function x() {}"
    assert_gen ast, "export function x(){}", beauty: false
  end

  should "convert export named declaration with function declaration generator" do
    ast = Builder.export_named_declaration(
      Builder.function_declaration(
        Builder.identifier(:x),
        [],
        [],
        Builder.block_statement([]),
        true
      )
    )

    assert_gen ast, "export function* x() {}"
    assert_gen ast, "export function*x(){}", beauty: false
  end

  should "convert export named declaration with class declaration" do
    ast = Builder.export_named_declaration(
      Builder.class_declaration(
        Builder.identifier(:y),
        Builder.class_body([])
      )
    )

    assert_gen ast, "export class y {}"
    assert_gen ast, "export class y{}", beauty: false
  end

  should "convert export named declaration with class declaration extends" do
    ast = Builder.export_named_declaration(
      Builder.class_declaration(
        Builder.identifier(:y),
        Builder.class_body([]),
        Builder.identifier(:z)
      )
    )

    assert_gen ast, "export class y extends z {}"
    assert_gen ast, "export class y extends z{}", beauty: false
  end
end
