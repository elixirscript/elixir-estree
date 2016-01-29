 defmodule ESTree.JSXMemberExpression do
  @type t :: %ESTree.JSXMemberExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    object: ESTree.JSXMemberExpression.t | ESTree.JSXIdentifier.t,
    property: ESTree.JSXIdentifier.t
  }

  defstruct type: "JSXMemberExpression", 
  loc: nil, 
  object: nil,
  property: nil

end 
