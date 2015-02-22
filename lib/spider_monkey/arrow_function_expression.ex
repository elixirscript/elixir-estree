defmodule SpiderMonkey.ArrowFunctionExpression do
  @type t :: %SpiderMonkey.ArrowFunctionExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    params: [SpiderMonkey.Pattern.t],
    defaults: [ SpiderMonkey.Expression.t ],
    rest: SpiderMonkey.Identifier.t | nil,
    body: SpiderMonkey.BlockStatement.t | SpiderMonkey.Expression.t,
    generator: boolean,
    expression: boolean  
  }
  defstruct type: "ArrowFunctionExpression", 
            loc: nil, 
            params: [],
            defaults: [],
            rest: nil,
            body: %SpiderMonkey.BlockStatement{},
            generator: false,
            expression: false  
end 