# v2.6.0
* Enhancements:
  * [Add parenthesis around await expressions in await expressions or in call expressions](https://github.com/elixirscript/elixir-estree/pull/20)
  * [Add ESTree.Tools.ESTreeJSONTransformer to translate ESTree JSON data into structs](https://github.com/bryanjos/elixir-estree/pull/21)

# v2.5.1
* Enhancements:
  * [Correct If statement identation](https://github.com/bryanjos/elixir-estree/pull/18)

# v2.5.0
* Enhancements:
  * [Greatly improved formatting of generated JavaScript](https://github.com/bryanjos/elixir-estree/pull/15)

# v2.4.2
* Fixes
  * [Expressions in variable declarations](https://github.com/bryanjos/elixir-estree/pull/13)

# v2.4.1
* Fixes
  * Handle edge case when string literal is a JSX child

# v2.4.0
* Enhancements:
  * Added exponential operators from ES2016

# v2.3.0
* Enhancements:
  * Added AssignmentProperty for use with ObjectPattern
  * Updated some typespecs to reflect updates in ESTree spec

# v2.2.0
* Enhancements:
  * Added structs for JSX AST

# v2.1.2

* Bug fixes
  * ESTree.Tools.Generator: updated UnaryExpression to put space in when operator is :typeof

# v2.1.1

* Enhancements
  * ESTree.Tools.Generator: Updated yield to account for delegate field

# v2.1.0

* Enhancements
  * Added async field to FunctionDeclaration and FunctionExpression
  * Added AwaitExpression

# v2.0.1

* Enhancements
  * Changed TemplateElement.value.value to TemplateElement.value.raw
  * Began adding indentation
  * Added empty string for when nil is given to generate

# v2.0.0

* Enhancements
  * Updated to latest ESTree Spec
  * Added ESTree.Tools.Generator to turn JavaScript AST into code

* Breaking
  * ESTree.Builder is now ESTree.Tools.Builder

# v1.0.1

* Enhancements
  * Add new regex property to literal

# v1.0.0

* Enhancements
  * Has the Node definitions from the [ESTree Spec](https://github.com/estree/estree)
  * Fills in ES6 Node definitions from [ast-types](https://github.com/benjamn/ast-types) and some from testing with [acorn](https://github.com/marijnh/acorn)
