defmodule SpiderMonkey.ComprehensionExpression do
  @type t :: %SpiderMonkey.ComprehensionExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    body: SpiderMonkey.Expression.t,
    blocks: [SpiderMonkey.ComprehensionBlock.t],
    filter: SpiderMonkey.Expression.t | nil,
  }
  defstruct type: "ComprehensionExpression", 
            loc: nil, 
            body: %SpiderMonkey.EmptyExpression{} ,
            blocks: [],
            filter: nil           
end 