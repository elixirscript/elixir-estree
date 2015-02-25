defmodule ESTree.TemplateLiteral do
  @type t :: %ESTree.TemplateLiteral{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    quasis: [ESTree.TemplateElement.t],
    expressions: [ESTree.Expression.t]
  }
  defstruct type: "TemplateLiteral", 
            loc: nil,
            quasis: [],
            expressions: []
end 