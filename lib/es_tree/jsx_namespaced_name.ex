defmodule ESTree.JSXNamespacedName do
  @type t :: %ESTree.JSXNamespacedName{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    namespace: ESTree.JSXIdentifier.t,
    name: ESTree.JSXIdentifier.t
  }

  defstruct type: "JSXNamespacedName", 
  loc: nil, 
  namespace: nil,
  name: nil

end 
