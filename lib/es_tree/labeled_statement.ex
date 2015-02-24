defmodule ESTree.LabeledStatement do
  @type t :: %ESTree.LabeledStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    label: ESTree.Identifier.t,
    body: ESTree.Statement.t 
  }
  defstruct type: "LabeledStatement", 
            loc: nil, 
            label: %ESTree.Identifier{},
            body: %ESTree.EmptyStatement{}
end 