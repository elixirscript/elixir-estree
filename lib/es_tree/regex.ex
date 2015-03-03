defmodule ESTree.Regex do
  @type t :: %ESTree.Regex{ 
    pattern: binary,
    flags: binary
  }
  defstruct pattern: "", flags: ""
end 