defmodule SpiderMonkey.FunctionExpression do
  @type t :: %SpiderMonkey.FunctionExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    id: SpiderMonkey.Identifier.t | nil,
    params: [SpiderMonkey.Pattern.t],
    defaults: [ SpiderMonkey.Expression.t  ],
    rest: SpiderMonkey.Identifier.t | nil,
    body: SpiderMonkey.BlockStatement.t | SpiderMonkey.Expression.t ,
    generator: boolean,
    expression: boolean  
  }
  defstruct type: "FunctionExpression", 
            loc: nil, 
            id: nil,
            params: [],
            defaults: [],
            rest: nil,
            body: %SpiderMonkey.BlockStatement{},
            generator: false,
            expression: false  
end 