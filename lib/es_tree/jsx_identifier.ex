defmodule ESTree.JSXIdentifier do
  @type t :: %ESTree.JSXIdentifier{ 
    type: binary,
    loc: ESTree.SourceLocation.t | nil, 
    name: binary
  }

  defstruct type: "JSXIdentifier", loc: nil, name: nil
end
