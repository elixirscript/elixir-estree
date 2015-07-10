defmodule ESTree.FunctionDeclaration do
  @type t :: %ESTree.FunctionDeclaration{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    id: ESTree.Identifier.t,
    params: [ESTree.Pattern.t ],
    defaults: [ ESTree.Expression.t  ],
    body: ESTree.BlockStatement.t | ESTree.Expression.t,
    generator: boolean,
    expression: boolean  
  }
  defstruct type: "FunctionDeclaration", 
            loc: nil, 
            id: %ESTree.Identifier{},
            params: [],
            defaults: [],
            body: %ESTree.BlockStatement{},
            generator: false,
            expression: false  
end 
