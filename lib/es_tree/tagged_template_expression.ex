defmodule ESTree.TaggedTemplateExpression do
  @type t :: %ESTree.TaggedTemplateExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    tag: ESTree.Expression.t,
    quasi: ESTree.TemplateLiteral.t
  }
  defstruct type: "TaggedTemplateExpression", 
            loc: nil,
            tag: %ESTree.EmptyExpression{},
            quasi: %ESTree.TemplateLiteral{}
end 