defmodule ESTree.MemberExpression do
  @type t :: %ESTree.MemberExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    object: ESTree.Expression.t | ESTree.Super.t,
    property: ESTree.Identifier.t | ESTree.Expression.t ,
    computed: boolean
  }
  defstruct type: "MemberExpression", 
            loc: nil, 
            object: %ESTree.EmptyExpression{},
            property: %ESTree.EmptyExpression{},
            computed: false
end 
