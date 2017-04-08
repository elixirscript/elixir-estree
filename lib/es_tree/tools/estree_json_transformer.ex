defmodule ESTree.Tools.ESTreeJSONTransformer do
  @moduledoc """
  Converts ESTree JSON into the Struct in the ESTree library
  """


  @spec convert(%{}) :: ESTree.Node.t
  def convert(json)

  def convert(%{"type" => "ArrayExpression"} = json) do
    %ESTree.ArrayExpression{
      elements: convert_property(json, "elements", [])
    }
  end

  def convert(%{"type" => "ArrayPattern"} = json) do
    %ESTree.ArrayPattern{
      elements: convert_property(json, "elements", [])
    }
  end

  def convert(%{"type" => "ArrowFunctionExpression"} = json) do
    %ESTree.ArrowFunctionExpression{
      generator: convert_property(json, "generator", false),
      expression: convert_property(json, "expression", false),
      params: convert_property(json, "params", []),
      body: convert_property(json, "body", [])
    }
  end

  def convert(%{"type" => "AssignmentExpression"} = json) do
    %ESTree.AssignmentExpression{
      operator: convert_property_to_atom(json, "operator", "="),
      left: convert_property(json, "left"),
      right: convert_property(json, "right")
    }
  end

  def convert(%{"type" => "AssignmentPattern"} = json) do
    %ESTree.AssignmentPattern{
      left: convert_property(json, "left"),
      right: convert_property(json, "right")
    }
  end

  def convert(%{"type" => "AwaitExpression"} = json) do
    %ESTree.AwaitExpression{
      argument: convert_property(json, "argument")
    }
  end

  def convert(%{"type" => "BinaryExpression"} = json) do
    %ESTree.BinaryExpression{
      operator: convert_property_to_atom(json, "operator", "="),
      left: convert_property(json, "left"),
      right: convert_property(json, "right")
    }
  end

  def convert(%{"type" => "BlockStatement"} = json) do
    %ESTree.BlockStatement{
      body: convert_property(json, "body", [])
    }
  end

  def convert(%{"type" => "BreakStatement"} = json) do
    %ESTree.BreakStatement{
      label: convert_property(json, "label")
    }
  end

  def convert(%{"type" => "CallExpression"} = json) do
    %ESTree.CallExpression{
      callee: convert_property(json, "callee", false),
      arguments: convert_property(json, "arguments", [])
    }
  end

  def convert(%{"type" => "CatchClause"} = json) do
    %ESTree.CatchClause{
      param: convert_property(json, "param"),
      body: convert_property(json, "body")
    }
  end

  def convert(%{"type" => "ClassBody"} = json) do
    %ESTree.ClassBody{
      body: convert_property(json, "body", [])
    }
  end

  def convert(%{"type" => "ClassDeclaration"} = json) do
    %ESTree.ClassDeclaration{
      id: convert_property(json, "id"),
      body: convert_property(json, "body"),
      superClass: convert_property(json, "superClass")
    }
  end

  def convert(%{"type" => "ClassExpression"} = json) do
    %ESTree.ClassExpression{
      body: convert_property(json, "body"),
      superClass: convert_property(json, "superClass")
    }
  end

  def convert(%{"type" => "ConditionalStatement"} = json) do
    %ESTree.ConditionalStatement{
      test: convert_property(json, "test"),
      alternate: convert_property(json, "alternate"),
      consequent: convert_property(json, "consequent")
    }
  end

  def convert(%{"type" => "ContinueStatement"} = json) do
    %ESTree.ContinueStatement{
      label: convert_property(json, "label")
    }
  end

  def convert(%{"type" => "DebuggerStatement"}) do
    %ESTree.DebuggerStatement{}
  end

  def convert(%{"type" => "DoWhileStatement"} = json) do
    %ESTree.DoWhileStatement{
      test: convert_property(json, "test"),
      body: convert_property(json, "body")
    }
  end

  def convert(%{"type" => "EmptyExpression"}) do
    %ESTree.EmptyExpression{}
  end

  def convert(%{"type" => "EmptyStatement"}) do
    %ESTree.EmptyStatement{}
  end

  def convert(%{"type" => "ExportAllDeclaration"} = json) do
    %ESTree.ExportAllDeclaration{
      source: convert_property(json, "source")
    }
  end

  def convert(%{"type" => "ExportDefaultDeclaration"} = json) do
    %ESTree.ExportDefaultDeclaration{
      declaration: convert_property(json, "declaration")
    }
  end

  def convert(%{"type" => "ExportNamedDeclaration"} = json) do
    %ESTree.ExportNamedDeclaration{
      declaration: convert_property(json, "declaration"),
      specifiers: convert_property(json, "specifiers", []),
      source: convert_property(json, "source")
    }
  end

  def convert(%{"type" => "ExportSpecifier"} = json) do
    %ESTree.ExportSpecifier{
      local: convert_property(json, "local"),
      exported: convert_property(json, "exported")
    }
  end

  def convert(%{"type" => "ExpressionStatement"} = json) do
    %ESTree.ExpressionStatement{
      expression: convert_property(json, "expression")
    }
  end

  def convert(%{"type" => "ForInStatement"} = json) do
    %ESTree.ForInStatement{
      left: convert_property(json, "left"),
      right: convert_property(json, "right"),
      body: convert_property(json, "body")
    }
  end

  def convert(%{"type" => "ForOfStatement"} = json) do
    %ESTree.ForOfStatement{
      left: convert_property(json, "left"),
      right: convert_property(json, "right"),
      body: convert_property(json, "body")
    }
  end

  def convert(%{"type" => "ForStatement"} = json) do
    %ESTree.ForStatement{
      init: convert_property(json, "init"),
      test: convert_property(json, "test"),
      update: convert_property(json, "update"),
      body: convert_property(json, "body")
    }
  end

  def convert(%{"type" => "FunctionDeclaration"} = json) do
    %ESTree.FunctionDeclaration{
      id: convert_property(json, "id"),
      params: convert_property(json, "params", []),
      defaults: convert_property(json, "defaults", []),
      body: convert_property(json, "body"),
      generator: convert_property(json, "generator", false),
      expression: convert_property(json, "expression", false),
      async: convert_property(json, "async", false)
    }
  end

  def convert(%{"type" => "FunctionExpression"} = json) do
    %ESTree.FunctionExpression{
      params: convert_property(json, "params", []),
      defaults: convert_property(json, "defaults", []),
      body: convert_property(json, "body"),
      generator: convert_property(json, "generator", false),
      expression: convert_property(json, "expression", false),
      async: convert_property(json, "async", false)
    }
  end

  def convert(%{"type" => "Identifier"} = json) do
    %ESTree.Identifier{
      name: convert_property(json, "name")
    }
  end

  def convert(%{"type" => "IfStatement"} = json) do
    %ESTree.IfStatement{
      test: convert_property(json, "test"),
      consequent: convert_property(json, "consequent"),
      alternate: convert_property(json, "alternate")
    }
  end

  def convert(%{"type" => "ImportDeclaration"} = json) do
    %ESTree.ImportDeclaration{
      specifiers: convert_property(json, "specifiers", []),
      source: convert_property(json, "source")
    }
  end

  def convert(%{"type" => "ImportDefaultSpecifier"} = json) do
    %ESTree.ImportDefaultSpecifier{
      local: convert_property(json, "local")
    }
  end

  def convert(%{"type" => "ImportNamespaceSpecifier"} = json) do
    %ESTree.ImportNamespaceSpecifier{
      local: convert_property(json, "local")
    }
  end

  def convert(%{"type" => "ImportSpecifier"} = json) do
    %ESTree.ImportSpecifier{
      local: convert_property(json, "local"),
      imported: convert_property(json, "imported")
    }
  end

  def convert(%{"type" => "JSXAttribute"} = json) do
    %ESTree.JSXAttribute{
      name: convert_property(json, "name"),
      value: convert_property(json, "value")
    }
  end

  def convert(%{"type" => "JSXClosingElement"} = json) do
    %ESTree.JSXClosingElement{
      name: convert_property(json, "name")
    }
  end

  def convert(%{"type" => "JSXElement"} = json) do
    %ESTree.JSXElement{
      openingElement: convert_property(json, "openingElement"),
      children: convert_property(json, "children", []),
      closingElement: convert_property(json, "closingElement")
    }
  end

  def convert(%{"type" => "JSXEmptyExpression"}) do
    %ESTree.JSXEmptyExpression{}
  end

  def convert(%{"type" => "JSXExpressionContainer"} = json) do
    %ESTree.JSXExpressionContainer{
      expression: convert_property(json, "expression")
    }
  end

  def convert(%{"type" => "JSXIdentifier"} = json) do
    %ESTree.JSXIdentifier{
      name: convert_property(json, "name")
    }
  end

  def convert(%{"type" => "JSXMemberExpression"} = json) do
    %ESTree.JSXMemberExpression{
      object: convert_property(json, "object"),
      property: convert_property(json, "property")
    }
  end

  def convert(%{"type" => "JSXNamespacedName"} = json) do
    %ESTree.JSXNamespacedName{
      namespace: convert_property(json, "namespace"),
      name: convert_property(json, "name")
    }
  end

  def convert(%{"type" => "JSXOpeningElement"} = json) do
    %ESTree.JSXOpeningElement{
      name: convert_property(json, "name"),
      attributes: convert_property(json, "attributes", []),
      selfClosing: convert_property(json, "selfClosing", false)
    }
  end

  def convert(%{"type" => "JSXSpreadAttribute"} = json) do
    %ESTree.JSXSpreadAttribute{
      argument: convert_property(json, "argument")
    }
  end

  def convert(%{"type" => "LabeledStatement"} = json) do
    %ESTree.LabeledStatement{
      label: convert_property(json, "label"),
      body: convert_property(json, "body")
    }
  end

  def convert(%{"type" => "Literal"} = json) do
    %ESTree.Literal{
      value: convert_property(json, "value")
    }
  end

  def convert(%{"type" => "LogicalExpression"} = json) do
    %ESTree.LogicalExpression{
      operator: convert_property_to_atom(json, "operator", ""),
      left: convert_property(json, "left"),
      right: convert_property(json, "right")
    }
  end

  def convert(%{"type" => "MemberExpression"} = json) do
    %ESTree.MemberExpression{
      object: convert_property(json, "object"),
      property: convert_property(json, "property"),
      computed: convert_property(json, "computed", false)
    }
  end

  def convert(%{"type" => "MetaProperty"} = json) do
    %ESTree.MetaProperty{
      meta: convert_property(json, "meta"),
      property: convert_property(json, "property")
    }
  end

  def convert(%{"type" => "MethodDefinition"} = json) do
    %ESTree.MethodDefinition{
      key: convert_property(json, "key"),
      value: convert_property(json, "value"),
      kind: convert_property_to_atom(json, "kind", ""),
      computed: convert_property(json, "computed", false),
      static: convert_property(json, "static", false)
    }
  end

  def convert(%{"type" => "NewExpression"} = json) do
    %ESTree.NewExpression{
      callee: convert_property(json, "callee", false),
      arguments: convert_property(json, "arguments", [])
    }
  end

  def convert(%{"type" => "ObjectExpression"} = json) do
    %ESTree.ObjectExpression{
      properties: convert_property(json, "properties", [])
    }
  end

  def convert(%{"type" => "ObjectPattern"} = json) do
    %ESTree.ObjectPattern{
      properties: convert_property(json, "properties", [])
    }
  end

  def convert(%{"type" => "Program"} = json) do
    %ESTree.Program{
      body: convert_property(json, "body", []),
      sourceType: convert_property(json, "sourceType", "module")
    }
  end

  def convert(%{"type" => "Property"} = json) do
    %ESTree.Property{
      key: convert_property(json, "key"),
      value: convert_property(json, "value"),
      kind: convert_property_to_atom(json, "kind", ""),
      method: convert_property(json, "method", false),
      shorthand: convert_property(json, "shorthand", false),
      computed: convert_property(json, "computed", false)
    }
  end

  def convert(%{"type" => "RestElement"} = json) do
    %ESTree.RestElement{
      argument: convert_property(json, "argument")
    }
  end

  def convert(%{"type" => "ReturnStatement"} = json) do
    %ESTree.ReturnStatement{
      argument: convert_property(json, "argument")
    }
  end

  def convert(%{"type" => "SequenceExpression"} = json) do
    %ESTree.SequenceExpression{
      expressions: convert_property(json, "expressions", [])
    }
  end

  def convert(%{"type" => "SpreadElement"} = json) do
    %ESTree.SpreadElement{
      argument: convert_property(json, "argument")
    }
  end

  def convert(%{"type" => "Super"}) do
    %ESTree.Super{}
  end

  def convert(%{"type" => "SwitchCase"} = json) do
    %ESTree.SwitchCase{
      test: convert_property(json, "test"),
      consequent: convert_property(json, "consequent")
    }
  end

  def convert(%{"type" => "SwitchStatement"} = json) do
    %ESTree.SwitchStatement{
      discriminant: convert_property(json, "discriminant"),
      cases: convert_property(json, "cases", [])
    }
  end

  def convert(%{"type" => "TaggedTemplateExpression"} = json) do
    %ESTree.TaggedTemplateExpression{
      tag: convert_property(json, "tag"),
      quasi: convert_property(json, "quasi")
    }
  end

  def convert(%{"type" => "TemplateElement"} = json) do
    value = case Map.get(json, "value") do
      map when is_map(map) ->
        %{
          cooked: convert_property(map, "cooked"),
          raw: convert_property(map, "raw")
        }
      other ->
        other
    end

    %ESTree.TemplateElement{
      value: value,
      tail: convert_property(json, "tail", false)
    }
  end

  def convert(%{"type" => "TemplateLiteral"} = json) do
    %ESTree.TemplateLiteral{
      quasis: convert_property(json, "quasis", []),
      expressions: convert_property(json, "expressions", [])
    }
  end

  def convert(%{"type" => "ThisExpression"}) do
    %ESTree.ThisExpression{}
  end

  def convert(%{"type" => "ThrowStatement"} = json) do
    %ESTree.ThrowStatement{
      argument: convert_property(json, "argument")
    }
  end

  def convert(%{"type" => "TryStatement"} = json) do
    %ESTree.TryStatement{
      block: convert_property(json, "block"),
      handler: convert_property(json, "handler"),
      finalizer: convert_property(json, "finalizer")
    }
  end

  def convert(%{"type" => "UnaryExpression"} = json) do
    %ESTree.UnaryExpression{
      operator: convert_property_to_atom(json, "operator", ""),
      prefix: convert_property(json, "prefix", false),
      argument: convert_property(json, "argument")
    }
  end

  def convert(%{"type" => "UpdateExpression"} = json) do
    %ESTree.UpdateExpression{
      operator: convert_property_to_atom(json, "operator", ""),
      prefix: convert_property(json, "prefix", false),
      argument: convert_property(json, "argument")
    }
  end

  def convert(%{"type" => "VariableDeclaration"} = json) do
    %ESTree.VariableDeclaration{
      kind: convert_property_to_atom(json, "kind", "var"),
      declarations: convert_property(json, "declarations", [])
    }
  end

  def convert(%{"type" => "VariableDeclarator"} = json) do
    %ESTree.VariableDeclarator{
      id: convert_property(json, "id"),
      init: convert_property(json, "init")
    }
  end

  def convert(%{"type" => "WhileStatement"} = json) do
    %ESTree.WhileStatement{
      test: convert_property(json, "test"),
      body: convert_property(json, "body")
    }
  end

  def convert(%{"type" => "WithStatement"} = json) do
    %ESTree.WithStatement{
      object: convert_property(json, "object"),
      body: convert_property(json, "body")
    }
  end

  def convert(%{"type" => "YieldExpression"} = json) do
    %ESTree.YieldExpression{
      argument: convert_property(json, "argument"),
      delegate: convert_property(json, "delegate", false)
    }
  end

  defp convert_property_to_atom(json, property, default) do
    json
    |> Map.get(property, default)
    |> String.to_atom()
  end

  defp convert_property(json, property, default \\ nil) do
    case Map.get(json, property, default) do
      nil ->
        nil
      list when is_list(list) ->
        Enum.map(list, &convert/1)
      map when is_map(map) ->
        convert(map)
      val ->
        val
    end
  end
end