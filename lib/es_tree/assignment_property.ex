defmodule ESTree.AssignmentProperty do
  @type t :: %ESTree.AssignmentProperty{
    type: binary,
    loc: ESTree.SourceLocation.t | nil,
    value: ESTree.Pattern.t
  }
  defstruct type: "Property",
  loc: nil,
  value: %ESTree.EmptyExpression{}
end
