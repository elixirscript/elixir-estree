defmodule SpiderMonkey.CatchClause do
  @type t :: %SpiderMonkey.CatchClause{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    param: SpiderMonkey.Pattern.t,
    body: SpiderMonkey.BlockStatement.t
  }
  defstruct type: "CatchClause", 
            loc: nil, 
            param: %SpiderMonkey.EmptyExpression{},
            body: %SpiderMonkey.BlockStatement{}
end 