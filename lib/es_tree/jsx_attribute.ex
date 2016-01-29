defmodule ESTree.JSXAttribute do
  @type t :: %ESTree.JSXAttribute{ 
    type: binary,
    loc: ESTree.SourceLocation.t | nil, 
    name: ESTree.JSXIdentifier.t | ESTree.JSXNamespacedName.t,
    value: ESTree.Literal.t | ESTree.JSXExpressionContainer.t | ESTree.JSXElement.t | nil
  }
  defstruct type: "JSXAttribute", loc: nil, name: nil, value: nil
end 
