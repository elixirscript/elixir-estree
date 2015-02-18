defmodule SpiderMonkey.MethodDefinition do
  @type t :: %SpiderMonkey.MethodDefinition{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    key: SpiderMonkey.Identifier.t,
    value: SpiderMonkey.FunctionExpression.t,
    kind: :"" | :get | :set,
    computed: boolean,
    static: boolean
  }
  defstruct type: "MethodDefinition", 
            loc: nil,
            key: %SpiderMonkey.Identifier{},
            value: %SpiderMonkey.FunctionExpression{},
            kind: :"",
            computed: false,
            static: false
end 