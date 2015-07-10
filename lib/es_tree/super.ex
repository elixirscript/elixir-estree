defmodule ESTree.Super do
  @type t :: %ESTree.Super{ 
    type: binary,
    loc: ESTree.SourceLocation.t | nil,
  }
  defstruct type: "Super", loc: nil
end
