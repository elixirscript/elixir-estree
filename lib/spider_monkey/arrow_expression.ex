defmodule SpiderMonkey.ArrowExpression do
  @type t :: %SpiderMonkey.ArrowExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    params: [SpiderMonkey.Pattern.t],
    defaults: [ SpiderMonkey.Expression.t ],
    rest: SpiderMonkey.Identifier.t | nil,
    body: SpiderMonkey.BlockStatement.t | SpiderMonkey.Expression.t,
    generator: boolean,
    expression: boolean  
  }
  defstruct type: "ArrowExpression", 
            loc: nil, 
            params: [],
            defaults: [],
            rest: nil,
            body: %SpiderMonkey.BlockStatement{},
            generator: false,
            expression: false  
end 