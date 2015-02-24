defmodule ESTree.SwitchStatement do
  @type t :: %ESTree.SwitchStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    discriminant: ESTree.Expression.t ,
    cases: [ESTree.SwitchCase.t]
  }
  defstruct type: "SwitchStatement", 
            loc: nil, 
            discriminant: %ESTree.EmptyExpression{},
            cases: []
end 