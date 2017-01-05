defmodule ESTree.Generator.Literal.Test do
  use ShouldI

  alias ESTree.Tools.Builder
  import ESTree.Test.Support

  should "convert numbers" do
    assert_gen Builder.literal(1), "1"
    assert_gen Builder.literal(10), "10"
    assert_gen Builder.literal(1.012), "1.012"
  end

  should "convert booleans" do
    assert_gen Builder.literal(true), "true"
    assert_gen Builder.literal(false), "false"
  end

  should "convert string" do
    assert_gen Builder.literal("hello"), "'hello'"
    assert_gen Builder.literal("goodbye"), "'goodbye'"
    assert_gen Builder.literal(:hello), "'hello'"
    assert_gen Builder.literal(:goodbye), "'goodbye'"
  end

  should "convert string escape" do
    assert_gen Builder.literal("\\"), "'\\\\'"
    assert_gen Builder.literal("\n"), "'\\n'"
    assert_gen Builder.literal("\r"), "'\\r'"
    assert_gen Builder.literal("\t"), "'\\t'"
    assert_gen Builder.literal("\b"), "'\\b'"
    assert_gen Builder.literal("\f"), "'\\f'"
    assert_gen Builder.literal("\v"), "'\\v'"
    assert_gen Builder.literal("\u2028"), "'\\u2028'"
    assert_gen Builder.literal("\u2029"), "'\\u2029'"
    assert_gen Builder.literal("\ufeff"), "'\\ufeff'"
    assert_gen Builder.literal("'"), "'\\''"
  end

  should "convert null" do
    assert_gen Builder.literal(nil), "null"
  end

  should "convert regex" do
    assert_gen Builder.literal(%{}, Builder.regex("^abc$", "i")), "/^abc$/i"
    assert_gen Builder.literal(%{}, Builder.regex("^abc$", "")), "/^abc$/"
    assert_gen Builder.literal(%{}, Builder.regex("", "")), "//"
  end
end
