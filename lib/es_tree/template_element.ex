defmodule ESTree.TemplateElement do
  @type t :: %ESTree.TemplateElement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    value: %{cooked: binary, value: binary},
    tail: boolean
  }
  defstruct type: "TemplateElement", 
            loc: nil,
            value: %{cooked: "", value: ""},
            tail: false
end 