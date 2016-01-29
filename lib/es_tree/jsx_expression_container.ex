defmodule ESTree.JSXExpressionContainer do
  @type t :: %ESTree.JSXExpressionContainer{
    type: binary,
    loc: ESTree.SourceLocation.t | nil,
    expression: ESTree.Expression.t | JSXEmptyExpression.t
  }

  defstruct type: "JSXExpressionContainer", loc: nil, expression: %ESTree.JSXEmptyExpression{}
end 
