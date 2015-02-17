defmodule SpiderMonkey.GeneratorExpression do
  @type t :: %SpiderMonkey.GeneratorExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    body: SpiderMonkey.Expression.t ,
    blocks: [SpiderMonkey.ComprehensionBlock.t],
    filter: SpiderMonkey.Expression.t  | nil,
  }
  defstruct type: "GeneratorExpression", 
            loc: nil, 
            body: %SpiderMonkey.EmptyExpression{} ,
            blocks: [],
            filter: nil           
end 