defmodule ESTree.JSXElement do
  @type t :: %ESTree.JSXElement{ 
    type: binary,
    loc: ESTree.SourceLocation.t | nil,
    openingElement: ESTree.JSXOpeningElement.t,
    children: [ESTree.Literal.t | ESTree.JSXExpressionContainer.t | ESTree.JSXElement.t],
    closingElement: ESTree.JSXClosingElement.t | nil
  }
  defstruct type: "JSXElement", loc: nil, openingElement: nil, children: [], closingElement: nil
end
