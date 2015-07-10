defmodule ESTree.RestElement do
  @type t :: %ESTree.RestElement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    argument: ESTree.Pattern.t
  }
  defstruct type: "RestElement", 
            loc: nil, 
            argument: %ESTree.Identifier{}
end
