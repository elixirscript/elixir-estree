defmodule SpiderMonkey.LetExpression do
  @type t :: %SpiderMonkey.LetExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    head: [SpiderMonkey.VariableDeclarator.t],
    body: SpiderMonkey.Statement.t 
  }
  defstruct type: "LetExpression", 
            loc: nil, 
            head: [],
            body: %SpiderMonkey.EmptyStatement{}
end 