defmodule ESTree.JSXText do
  @type t :: %ESTree.JSXText{
    type: binary,
    value: binary,
    loc: ESTree.SourceLocation.t | nil
  }
  defstruct type: "JSXText", loc: nil, value: nil
end
