defmodule ESTree.JSXClosingElement do
  @type t :: %ESTree.JSXClosingElement{ 
    type: binary,
    loc: ESTree.SourceLocation.t | nil, 
    name: ESTree.JSXIdentifier.t | ESTree.JSXMemberExpression.t | ESTree.JSXNamespacedName.t
  }
  defstruct type: "JSXClosingElement", loc: nil, name: nil
end 
