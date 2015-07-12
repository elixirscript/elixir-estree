## Elixir-ESTree [![Documentation](https://img.shields.io/badge/docs-hexpm-blue.svg)](http://hexdocs.pm/estree/) [![Downloads](https://img.shields.io/hexpm/dt/estree.svg)](https://hex.pm/packages/estree)

Defines structs that represent the JavaScript AST nodes from the ESTree spec. 

[ESTree Spec](https://github.com/estree/estree)

Also includes a JavaScript AST to JavaScript code generator.

```elixir
alias ESTree.Tools.Builder
alias ESTree.Tools.Generator

ast = Builder.array_expression([
  Builder.literal(1),
  Builder.identifier(:a)
])

Generator.generate(ast)
#"[1, a]"
```
