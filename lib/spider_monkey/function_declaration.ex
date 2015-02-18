defmodule SpiderMonkey.FunctionDeclaration do
  @type t :: %SpiderMonkey.FunctionDeclaration{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    id: SpiderMonkey.Identifier.t,
    params: [SpiderMonkey.Pattern.t ],
    defaults: [ SpiderMonkey.Expression.t  ],
    rest: SpiderMonkey.Identifier.t | nil,
    body: SpiderMonkey.BlockStatement.t,
    generator: boolean,
    expression: boolean  
  }
  defstruct type: "FunctionDeclaration", 
            loc: nil, 
            id: %SpiderMonkey.Identifier{},
            params: [],
            defaults: [],
            rest: nil,
            body: %SpiderMonkey.BlockStatement{},
            generator: false,
            expression: false  
end 