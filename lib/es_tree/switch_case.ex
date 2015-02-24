defmodule ESTree.SwitchCase do
  @type t :: %ESTree.SwitchCase{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    test: ESTree.Expression.t | nil,
    consequent: [ESTree.Statement.t]
  }
  defstruct type: "SwitchCase", 
            loc: nil, 
            test: nil,
            consequent: []
end 