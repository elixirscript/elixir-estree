defmodule ESTree.MethodDefinition do
  @type t :: %ESTree.MethodDefinition{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    key: ESTree.Identifier.t,
    value: ESTree.FunctionExpression.t,
    kind: :"" | :get | :set,
    computed: boolean,
    static: boolean
  }
  defstruct type: "MethodDefinition", 
            loc: nil,
            key: %ESTree.Identifier{},
            value: %ESTree.FunctionExpression{},
            kind: :"",
            computed: false,
            static: false
end 