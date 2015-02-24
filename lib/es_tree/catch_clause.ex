defmodule ESTree.CatchClause do
  @type t :: %ESTree.CatchClause{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    param: ESTree.Pattern.t,
    body: ESTree.BlockStatement.t
  }
  defstruct type: "CatchClause", 
            loc: nil, 
            param: %ESTree.EmptyExpression{},
            body: %ESTree.BlockStatement{}
end 