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
