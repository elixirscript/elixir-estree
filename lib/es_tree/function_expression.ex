defmodule ESTree.FunctionExpression do
  @type t :: %ESTree.FunctionExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    params: [ESTree.Pattern.t],
    defaults: [ ESTree.Expression.t  ],
    body: ESTree.BlockStatement.t,
    generator: boolean,
    expression: boolean  
  }
  defstruct type: "FunctionExpression", 
            loc: nil, 
            params: [],
            defaults: [],
            body: %ESTree.BlockStatement{},
            generator: false,
            expression: false  
end 
