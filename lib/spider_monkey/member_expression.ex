defmodule SpiderMonkey.MemberExpression do
  @type t :: %SpiderMonkey.MemberExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil, 
    object: SpiderMonkey.Expression.t ,
    property: SpiderMonkey.Identifier.t | SpiderMonkey.Expression.t ,
    computed: boolean
  }
  defstruct type: "MemberExpression", 
            loc: nil, 
            object: %SpiderMonkey.EmptyExpression{},
            property: %SpiderMonkey.EmptyExpression{},
            computed: false
end 