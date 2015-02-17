defmodule SpiderMonkey.VariableDeclarator do
  @type t :: %SpiderMonkey.VariableDeclarator{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    id: SpiderMonkey.Pattern.t ,
    init: SpiderMonkey.Expression.t  | nil
  }
  defstruct type: "VariableDeclarator", 
            loc: nil,
            id: %SpiderMonkey.EmptyExpression{},
            init: nil
end 