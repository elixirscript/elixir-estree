defmodule ESTree.SpreadElement do
  @type t :: %ESTree.SpreadElement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    argument: ESTree.Expression.t
  }
  defstruct type: "SpreadElement", 
            loc: nil, 
            argument: %ESTree.EmptyExpression{}
end
