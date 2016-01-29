defmodule ESTree.JSXOpeningElement do
  @type t :: %ESTree.JSXOpeningElement{ 
    type: binary,
    loc: ESTree.SourceLocation.t | nil, 
    name: ESTree.JSXIdentifier.t | ESTree.JSXMemberExpression.t | ESTree.JSXNamespacedName.t,
    attributes: [ ESTree.JSXAttribute.t | ESTree.JSXSpreadAttribute.t ],
    selfClosing: boolean
  }
  defstruct type: "JSXOpeningElement", loc: nil, name: nil, attributes: [], selfClosing: false
end 
