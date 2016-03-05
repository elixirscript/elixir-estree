defmodule ESTree.ObjectPattern do
  @type t :: %ESTree.ObjectPattern{
    type: binary,
    loc: ESTree.SourceLocation.t | nil,
    properties: [ESTree.AssignmentProperty.t]
  }
  defstruct type: "ObjectPattern",
            loc: nil,
            properties: []
end
