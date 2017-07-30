defmodule ESTree.ArrowFunctionExpression do
  @type t :: %ESTree.ArrowFunctionExpression{
    type: binary,
    loc: ESTree.SourceLocation.t | nil,
    params: [ESTree.Pattern.t],
    defaults: [ ESTree.Expression.t ],
    rest: ESTree.Identifier.t | nil,
    body: ESTree.BlockStatement.t | ESTree.Expression.t,
    generator: boolean,
    expression: boolean,
    async: boolean
  }
  defstruct type: "ArrowFunctionExpression",
            loc: nil,
            params: [],
            defaults: [],
            rest: nil,
            body: %ESTree.BlockStatement{},
            generator: false,
            expression: false,
            async: false
end
