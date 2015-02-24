defmodule ESTree.FunctionDeclaration do
  @type t :: %ESTree.FunctionDeclaration{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    id: ESTree.Identifier.t,
    params: [ESTree.Pattern.t ],
    defaults: [ ESTree.Expression.t  ],
    rest: ESTree.Identifier.t | nil,
    body: ESTree.BlockStatement.t,
    generator: boolean,
    expression: boolean  
  }
  defstruct type: "FunctionDeclaration", 
            loc: nil, 
            id: %ESTree.Identifier{},
            params: [],
            defaults: [],
            rest: nil,
            body: %ESTree.BlockStatement{},
            generator: false,
            expression: false  
end 