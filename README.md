## Elixir-ESTree [![Documentation](https://img.shields.io/badge/docs-hexpm-blue.svg)](http://hexdocs.pm/estree/) [![Downloads](https://img.shields.io/hexpm/dt/estree.svg)](https://hex.pm/packages/estree) [![Build Status](https://travis-ci.org/elixirscript/elixir-estree.svg?branch=master)](https://travis-ci.org/elixirscript/elixir-estree)


Defines structs that represent the JavaScript AST nodes from the ESTree spec. 

[ESTree Spec](https://github.com/estree/estree)

[JSX AST Spec](https://github.com/facebook/jsx)

Also includes a JavaScript AST to JavaScript code generator.

```elixir
alias ESTree.Tools.Builder
alias ESTree.Tools.Generator

ast = Builder.array_expression([
  Builder.literal(1),
  Builder.identifier(:a)
])

Generator.generate(ast)
# "[1, a]"

#jsx ast and generation
    ast = Builder.jsx_element(
      Builder.jsx_opening_element(
        Builder.jsx_identifier(
          "Test"
        )
      ),
      [],
      Builder.jsx_closing_element(
        Builder.jsx_identifier(
          "Test"
        )
      )
    )
    
Generator.generate(ast)
# "<Test></Test>"
```
