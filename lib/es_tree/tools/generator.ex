defmodule ESTree.Tools.Generator do
  @moduledoc """
  Responsible for taking JavaScript AST and converting
  it to JavaScript code
  """

  alias ESTree.ArrayExpression
  alias ESTree.ArrayPattern
  alias ESTree.ArrowFunctionExpression
  alias ESTree.AssignmentExpression
  alias ESTree.AssignmentPattern
  alias ESTree.AssignmentProperty
  alias ESTree.AwaitExpression
  alias ESTree.BinaryExpression
  alias ESTree.BlockStatement
  alias ESTree.BreakStatement
  alias ESTree.CallExpression
  alias ESTree.CatchClause
  alias ESTree.ClassBody
  alias ESTree.ClassDeclaration
  alias ESTree.ClassExpression
  alias ESTree.ConditionalStatement
  alias ESTree.ContinueStatement
  alias ESTree.DebuggerStatement
  alias ESTree.DoWhileStatement
  alias ESTree.EmptyStatement
  alias ESTree.ExportAllDeclaration
  alias ESTree.ExportDefaultDeclaration
  alias ESTree.ExportNamedDeclaration
  alias ESTree.ExportSpecifier
  alias ESTree.ExpressionStatement
  alias ESTree.ForInStatement
  alias ESTree.ForOfStatement
  alias ESTree.ForStatement
  alias ESTree.FunctionDeclaration
  alias ESTree.FunctionExpression
  alias ESTree.Identifier
  alias ESTree.IfStatement
  alias ESTree.ImportDeclaration
  alias ESTree.ImportDefaultSpecifier
  alias ESTree.ImportNamespaceSpecifier
  alias ESTree.ImportSpecifier
  alias ESTree.JSXAttribute
  alias ESTree.JSXClosingElement
  alias ESTree.JSXElement
  alias ESTree.JSXEmptyExpression
  alias ESTree.JSXExpressionContainer
  alias ESTree.JSXIdentifier
  alias ESTree.JSXMemberExpression
  alias ESTree.JSXNamespacedName
  alias ESTree.JSXOpeningElement
  alias ESTree.JSXSpreadAttribute
  alias ESTree.LabeledStatement
  alias ESTree.Literal
  alias ESTree.LogicalExpression
  alias ESTree.MemberExpression
  alias ESTree.MetaProperty
  alias ESTree.MethodDefinition
  alias ESTree.NewExpression
  alias ESTree.ObjectExpression
  alias ESTree.ObjectPattern
  alias ESTree.Program
  alias ESTree.Property
  alias ESTree.RestElement
  alias ESTree.ReturnStatement
  alias ESTree.SequenceExpression
  alias ESTree.SpreadElement
  alias ESTree.Super
  alias ESTree.SwitchCase
  alias ESTree.SwitchStatement
  alias ESTree.TaggedTemplateExpression
  alias ESTree.TemplateElement
  alias ESTree.TemplateLiteral
  alias ESTree.ThisExpression
  alias ESTree.ThrowStatement
  alias ESTree.TryStatement
  alias ESTree.UnaryExpression
  alias ESTree.UpdateExpression
  alias ESTree.VariableDeclaration
  alias ESTree.VariableDeclarator
  alias ESTree.WhileStatement
  alias ESTree.WithStatement
  alias ESTree.YieldExpression

  @operator_precedence %{
    ||:  3,
    &&:  4,
    |:   5,
    ^:   6,
    &:   7,
    ==:  8,
    !=:  8,
    ===: 8,
    !==: 8,
    <:   9,
    >:   9,
    <=:  9,
    >=:  9,
    in:  9,
    instanceof: 9,
    "<<":  10,
    ">>":  10,
    >>>: 10,
    +:   11,
    -:   11,
    *:   12,
    %:   12,
    /:   12,
    "**":  13
  }

  @expressions_precedence %{
    ArrayExpression          => 20,
    TaggedTemplateExpression => 20,
    ThisExpression           => 20,
    Identifier               => 20,
    Literal                  => 18,
    TemplateLiteral          => 20,
    Super                    => 20,
    SequenceExpression       => 20,
    MemberExpression         => 19,
    CallExpression           => 19,
    NewExpression            => 19,
    ArrowFunctionExpression  => 18,
    ClassExpression          => 17,
    FunctionExpression       => 17,
    ObjectExpression         => 17,
    UpdateExpression         => 16,
    UnaryExpression          => 15,
    BinaryExpression         => 14,
    LogicalExpression        => 13,
    ConditionalStatement     => 4,
    AssignmentExpression     => 3,
    YieldExpression          => 2,
    RestElement              => 1
  }

  @operators [
    :-, :+ , :! , :"~" , :typeof , :void , :delete,
    :== , :!= , :=== , :!== , :< , :<= , :> , :>= ,
    :"<<" , :">>" , :>>> , :+ , :- , :* , :/ , :% , :| ,
    :^ , :& , :in , :instanceof, :|| , :&&, := , :"+=" ,
    :"-=" , :"*=" , :"/=" , :"%=" , :"<<=" , :">>=" ,
    :">>>=" , :"|=" , :"^=" , :"&=", :++, :--
  ]

  @spec generate(ESTree.operator | ESTree.Node.t, boolean) :: binary
  def generate(value, beauty \\ true) do
    opts = if beauty do
      %{
        beauty: true,
        wh_sep: " ",
        comma_sep: ", ",
        colon_sep: ": "
      }
    else
      %{
        beauty: false,
        wh_sep: "",
        comma_sep: ",",
        colon_sep: ":"
      }
    end
    |> Map.merge(
      %{indent: 0,
        indent_start: 0,
        indent_level: 4,
        no_trailing_semicolon: false
      }
    )

    value
    |> do_generate(opts)
    |> :erlang.iolist_to_binary()
  end

  defp do_generate(nil, _opts) do
    []
  end

  defp do_generate(operator, _opts) when operator in @operators do
    to_string(operator)
  end

  # ArrayExpression

  defp do_generate(%ArrayExpression{elements: nil}, _opts) do
    "[]"
  end

  defp do_generate(%ArrayExpression{elements: []}, _opts) do
    "[]"
  end

  defp do_generate(%ArrayExpression{elements: elements}, opts) do
    elements = elements
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    ["[", elements, "]"]
  end

  # ArrayPattern

  defp do_generate(%ArrayPattern{elements: nil}, _opts) do
    "[]"
  end

  defp do_generate(%ArrayPattern{elements: []}, _opts) do
    "[]"
  end

  defp do_generate(%ArrayPattern{elements: elements}, opts) do
    elements = elements
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    ["[", elements, "]"]
  end

  # ArrowFunctionExpression

  defp do_generate(%ArrowFunctionExpression{params: params, defaults: defaults, body: body, generator: generator} = ast, %{wh_sep: wh_sep} = opts) do
    generator = if generator, do: "*", else: ""
    params = params_and_defaults(params, defaults, opts)
    body = if body.__struct__ == ObjectExpression do
      ["(", do_generate(body, opts), ")"]
    else
      do_generate(body, opts)
    end

    if not opts.beauty and length(ast.params) == 1 do
      [params, generator, wh_sep, "=>", wh_sep, body]
    else
      ["(", params, ")", generator, wh_sep, "=>", wh_sep, body]
    end
  end

  # AssignmentExpression

  defp do_generate(%AssignmentExpression{operator: operator, left: left, right: right}, %{wh_sep: wh_sep} = opts) do
    operator = do_generate(operator, opts)
    left = do_generate(left, opts)
    right = do_generate(right, opts)

    [left, wh_sep, operator, wh_sep, right]
  end

  # AssignmentPattern

  defp do_generate(%AssignmentPattern{left: left, right: right}, %{wh_sep: wh_sep} = opts) do
    left = do_generate(left, opts)
     right = do_generate(right, opts)

    [left, wh_sep, "=", wh_sep, right]
  end

  # AssignmentProperty

  defp do_generate(%AssignmentProperty{value: value}, opts) do
    do_generate(value, opts)
  end

  # AwaitExpression

  defp do_generate(%AwaitExpression{argument: argument, all: _all}, opts) do
    ["await ", do_generate(argument, opts)]
  end

  # BinaryExpression

  defp do_generate(%BinaryExpression{operator: operator, left: left, right: right} = node, opts) when operator in [:in, :instanceof] do
    operator = [" ", do_generate(operator, opts), " "]
    left = format_binary_expression(left, node, false, opts)
    right = format_binary_expression(right, node, true, opts)

    if node.operator == :in do
      ["(", left, operator, right, ")"]
    else
      [left, operator, right]
    end
  end

  defp do_generate(%BinaryExpression{operator: operator, left: left, right: right} = node, %{wh_sep: wh_sep} = opts) do
    operator = do_generate(operator, opts)
    left = format_binary_expression(left, node, false, opts)
    right = format_binary_expression(right, node, true, opts)

    [left, wh_sep, operator, wh_sep, right]
  end

  # BlockStatement

  defp do_generate(%BlockStatement{body: []}, _opts) do
    "{}"
  end

  defp do_generate(%BlockStatement{body: body}, opts) do
    close_bracket = if opts.beauty do
      ["\n", indent(opts), "}"]
    else
      "}"
    end

    opts = next_indent(opts)
    i = indent(opts)

    sep = if opts.beauty do
      ["\n\n", i]
    else
      ""
    end

    open_bracket = if opts.beauty do
      ["{\n", i]
    else
      "{"
    end

    statements = body
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(sep)

    [open_bracket, statements, close_bracket]
  end

  # BreakStatement

  defp do_generate(%BreakStatement{label: nil}, _opts) do
    "break;"
  end

  defp do_generate(%BreakStatement{label: label}, opts) do
    ["break ", do_generate(label, opts), ";"]
  end

  # CallExpression

  defp do_generate(%CallExpression{callee: callee, arguments: arguments}, opts) do
    precedence = Map.get(@expressions_precedence, callee.__struct__)
    callee = do_generate(callee, opts)

    callee = if precedence < @expressions_precedence[CallExpression] do
      ["(", callee, ")"]
    else
      callee
    end

    arguments = arguments
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    [callee, "(", arguments, ")"]
  end

  # CatchClause

  defp do_generate(%CatchClause{param: param, body: body}, %{wh_sep: wh_sep} = opts) do
    param = do_generate(param, opts)
    body = do_generate(body, opts)

    ["catch", wh_sep, "(", param, ")", wh_sep, body]
  end

  # ClassBody

  defp do_generate(%ClassBody{body: []}, _opts) do
    "{}"
  end

  defp do_generate(%ClassBody{body: body}, opts) do
    close_bracket = if opts.beauty do
      ["\n", indent(opts), "}"]
    else
      "}"
    end

    opts = next_indent(opts)
    i = indent(opts)

    sep = if opts.beauty do
      [";\n", i]
    else
      ";"
    end

    open_bracket = if opts.beauty do
      ["{\n", i]
    else
      "{"
    end

    statements = body
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(sep)

    [open_bracket, statements, close_bracket]
  end

  # ClassDeclaration

  defp do_generate(%ClassDeclaration{id: id, body: body, superClass: nil}, %{wh_sep: wh_sep} = opts) do
    id = do_generate(id, opts)
    body = do_generate(body, opts)

    ["class ", id, wh_sep, body]
  end

  defp do_generate(%ClassDeclaration{id: id, body: body, superClass: super_class}, %{wh_sep: wh_sep} = opts) do
    id = do_generate(id, opts)
    body = do_generate(body, opts)
    super_class = do_generate(super_class, opts)

    ["class ", id, " extends ", super_class, wh_sep, body]
  end

  # ClassExpression

  defp do_generate(%ClassExpression{body: body, superClass: nil}, %{wh_sep: wh_sep} = opts) do
    ["class", wh_sep, do_generate(body, opts)]
  end

  defp do_generate(%ClassExpression{body: body, superClass: super_class}, %{wh_sep: wh_sep} = opts) do
    super_class = do_generate(super_class, opts)
    body = do_generate(body, opts)

    ["class extends ", super_class, wh_sep, body]
  end

  # ConditionalStatement

  defp do_generate(%ConditionalStatement{test: test, alternate: alternate, consequent: consequent}, %{wh_sep: wh_sep} = opts) do
    precedence = Map.get(@expressions_precedence, test.__struct__)
    test = do_generate(test, opts)

    test = if precedence < @expressions_precedence[ConditionalStatement] do
      ["(", test, ")"]
    else
      test
    end

    consequent = do_generate(consequent, opts)
    alternate = do_generate(alternate, opts)

    [test, wh_sep, "?", wh_sep, consequent, wh_sep, ":", wh_sep, alternate]
  end

  # ContinueStatement

  defp do_generate(%ContinueStatement{label: nil}, _opts) do
    "continue;"
  end

  defp do_generate(%ContinueStatement{label: label}, opts) do
    ["continue ", do_generate(label, opts), ";"]
  end

  # DebuggerStatement

  defp do_generate(%DebuggerStatement{}, _opts) do
    "debugger;"
  end

  # DoWhileStatement

  defp do_generate(%DoWhileStatement{test: test, body: body}, %{wh_sep: wh_sep} = opts) do
    test = do_generate(test, opts)
    body = do_generate(body, opts)

    ["do", wh_sep, body, wh_sep, "while", wh_sep, "(", test, ");"]
  end

  # EmptyStatement

  defp do_generate(%EmptyStatement{}, _opts) do
    ";"
  end

  # ExportAllDeclaration

  defp do_generate(%ExportAllDeclaration{source: source}, %{wh_sep: wh_sep} = opts) do
    source = do_generate(source, opts)

    ["export", wh_sep, "*", wh_sep, "from", wh_sep, source, ";"]
  end

  # ExportDefaultDeclaration

  defp do_generate(%ExportDefaultDeclaration{declaration: %ClassDeclaration{} = declaration}, opts) do
    ["export default ", do_generate(declaration, opts)]
  end

  defp do_generate(%ExportDefaultDeclaration{declaration: %FunctionDeclaration{} = declaration}, opts) do
    ["export default ", do_generate(declaration, opts)]
  end

  defp do_generate(%ExportDefaultDeclaration{declaration: declaration}, opts) do
    ["export default ", do_generate(declaration, opts), ";"]
  end

  # ExportNamedDeclaration

  defp do_generate(%ExportNamedDeclaration{declaration: declaration, specifiers: [], source: nil}, opts) do
    ["export ", do_generate(declaration, opts)]
  end

  defp do_generate(%ExportNamedDeclaration{declaration: nil, specifiers: specifiers, source: nil}, %{wh_sep: wh_sep} = opts) do
    specifiers = specifiers
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    ["export", wh_sep, "{", wh_sep, specifiers, wh_sep, "};"]
  end

  defp do_generate(%ExportNamedDeclaration{declaration: nil, specifiers: specifiers, source: source}, %{wh_sep: wh_sep} = opts) do
    specifiers = specifiers
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    ["export", wh_sep, "{", wh_sep, specifiers, wh_sep, "}", wh_sep, "from", wh_sep, do_generate(source, opts), ";"]
  end

  # ExportSpecifier

  defp do_generate(%ExportSpecifier{local: local, exported: exported}, opts) do
    if local == exported do
      do_generate(local, opts)
    else
      [do_generate(exported, opts), " as ", do_generate(local, opts)]
    end
  end

  # ExpressionStatement

  defp do_generate(%ExpressionStatement{expression: expression}, opts) do
    precedence = Map.get(@expressions_precedence, expression.__struct__)

    if precedence == 17 or (precedence == 3 and expression.left.__struct__ == ObjectPattern)  do
      ["(", do_generate(expression, opts), ");"]
    else
      [do_generate(expression, opts), ";"]
    end
  end

  # ForInStatement

  defp do_generate(%ForInStatement{left: left, right: right, body: body}, %{wh_sep: wh_sep} = opts) do
    left = do_generate(left, %{opts | no_trailing_semicolon: true})
    right = do_generate(right, opts)
    body = do_generate(body, opts)

    ["for", wh_sep, "(", left, " in ", right, ")", wh_sep, body]
  end

  # ForOfStatement

  defp do_generate(%ForOfStatement{left: left, right: right, body: body}, %{wh_sep: wh_sep} = opts) do
    left = do_generate(left, %{opts | no_trailing_semicolon: true})
    right = do_generate(right, opts)
    body = do_generate(body, opts)

    ["for", wh_sep, "(", left, " of ", right, ")", wh_sep, body]
  end

  # ForStatement

  defp do_generate(%ForStatement{init: init, test: test, update: update, body: body}, %{wh_sep: wh_sep} = opts) do
    init = do_generate(init, %{opts | no_trailing_semicolon: true})
    test = do_generate(test, opts)
    update = do_generate(update, opts)
    body = do_generate(body, opts)

    ["for", wh_sep, "(", init, ";", wh_sep, test, ";", wh_sep, update, ")", wh_sep, body]
  end

  # FunctionDeclaration

  defp do_generate(%FunctionDeclaration{generator: generator, async: async, id: id, params: params, defaults: defaults, body: body}, %{wh_sep: wh_sep} = opts) do
    generator = if generator, do: "*", else: ""
    async = if async, do: "async ", else: ""
    params = params_and_defaults(params, defaults, opts)
    id = do_generate(id, opts)
    body = do_generate(body, opts)

    sep = if generator == "" do
      " "
    else
      wh_sep
    end

    [async, "function", generator, sep, id, "(", params, ")", wh_sep, body]
  end

  # FunctionExpression

  defp do_generate(%FunctionExpression{generator: generator, async: async, params: params, defaults: defaults, body: body}, %{wh_sep: wh_sep} = opts) do
    generator = if generator, do: "*", else: ""
    async = if async, do: "async ", else: ""
    params = params_and_defaults(params, defaults, opts)
    body = do_generate(body, opts)

    [async, "function", generator, "(", params, ")", wh_sep, body]
  end

  # Identifier

  defp do_generate(%Identifier{name: name}, _opts) do
    to_string(name)
  end

  # IfStatement

  defp do_generate(%IfStatement{test: test, consequent: consequent, alternate: nil}, %{wh_sep: wh_sep} = opts) do
    test = do_generate(test, opts)

    sep_c = if opts.beauty do
      ["\n", indent(next_indent(opts))]
    else
      ""
    end

    consequent =
      case consequent do
        %BlockStatement{} ->
          [wh_sep, do_generate(consequent, opts)]

        _ ->
          [sep_c, do_generate(consequent, opts)]
      end

    ["if", wh_sep, "(", test, ")", consequent]
  end

  defp do_generate(%IfStatement{test: test, consequent: consequent, alternate: alternate}, %{wh_sep: wh_sep} = opts) do
    is_cons_block = consequent.__struct__ == BlockStatement

    i_1 = indent(opts)
    i_2 = indent(next_indent(opts))

    consequent =
      case consequent do
        %BlockStatement{} ->
          [wh_sep, do_generate(consequent, opts)]

        _ ->
          indent = if opts.beauty do
              ["\n", i_2]
            else
              ""
            end

          [indent, do_generate(consequent, opts)]
      end

    alternate_indent = if opts.beauty do
      ["\n", i_2]
    else
      " "
    end

    alternate = if is_cons_block do
      case alternate do
        %BlockStatement{} ->
          [wh_sep, "else", wh_sep, do_generate(alternate, opts)]

        %IfStatement{} ->
          [wh_sep, "else ", do_generate(alternate, opts)]

        _ ->
          [wh_sep, "else", alternate_indent, do_generate(alternate, opts)]
      end
    else
      indent = if opts.beauty do
        ["\n", i_1]
      else
        ""
      end

      case alternate do
        %BlockStatement{} ->
          [indent, "else", wh_sep, do_generate(alternate, opts)]

        %IfStatement{} ->
          [indent, "else ", do_generate(alternate, opts)]

        _ ->
          [indent, "else", alternate_indent, do_generate(alternate, opts)]
      end
    end

    test = do_generate(test, opts)

    ["if", wh_sep, "(", test, ")", consequent, alternate]
  end

  # ImportDeclaration

  defp do_generate(%ImportDeclaration{specifiers: [%ImportDefaultSpecifier{}] = specifiers, source: source}, %{wh_sep: wh_sep} = opts) do
    specifiers = specifiers
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    source = do_generate(source, opts)

    ["import ", specifiers, " from", wh_sep, source, ";"]
  end

  defp do_generate(%ImportDeclaration{specifiers: [%ImportNamespaceSpecifier{}] = specifiers, source: source}, %{wh_sep: wh_sep} = opts) do
    specifiers = specifiers
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    ["import", specifiers, " from", wh_sep, do_generate(source, opts), ";"]
  end

  defp do_generate(%ImportDeclaration{specifiers: specifiers, source: source}, %{wh_sep: wh_sep} = opts) do
    specifiers = specifiers
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    ["import", wh_sep, "{", wh_sep, specifiers, wh_sep, "}", wh_sep, "from", wh_sep, do_generate(source, opts), ";"]
  end

  # ImportDefaultSpecifier

  defp do_generate(%ImportDefaultSpecifier{local: local}, opts) do
    do_generate(local, opts)
  end

  # ImportNamespaceSpecifier

  defp do_generate(%ImportNamespaceSpecifier{local: local}, %{wh_sep: wh_sep} = opts) do
    [wh_sep, "*", wh_sep, "as ", do_generate(local, opts)]
  end

  # ImportSpecifier

  defp do_generate(%ImportSpecifier{local: local, imported: imported}, opts) do
    if local == imported do
      do_generate(local, opts)
    else
      [do_generate(imported, opts), " as ", do_generate(local, opts)]
    end
  end

  # JSXAttribute

  defp do_generate(%JSXAttribute{name: name, value: value}, opts) do
    [do_generate(name, opts), "=", do_generate(value, opts)]
  end

  # JSXClosingElement

  defp do_generate(%JSXClosingElement{name: name}, opts) do
    ["</", do_generate(name, opts), ">"]
  end

  # JSXElement

  defp do_generate(%JSXElement{openingElement: opening_element, children: children, closingElement: closing_element}, opts) do
    opening_element = do_generate(opening_element, opts)
    children = generate_jsx_children(children, opts)
    closing_element = do_generate(closing_element, opts)

    [opening_element, children, closing_element]
  end

  # JSXEmptyExpression

  defp do_generate(%JSXEmptyExpression{}, _opts) do
    ""
  end

  # JSXExpressionContainer

  defp do_generate(%JSXExpressionContainer{expression: expression}, opts) do
    ["{", do_generate(expression, opts), "}"]
  end

  # JSXIdentifier

  defp do_generate(%JSXIdentifier{name: name}, _opts) when is_binary(name) do
    name
  end

  defp do_generate(%JSXIdentifier{name: name}, _opts) when is_atom(name) do
    to_string(name)
  end

  # JSXMemberExpression

  defp do_generate(%JSXMemberExpression{object: object, property: property}, opts) do
    [do_generate(object, opts), ".", do_generate(property, opts)]
  end

  # JSXNamespacedName

  defp do_generate(%JSXNamespacedName{namespace: namespace, name: name}, opts) do
    [do_generate(namespace, opts), ":", do_generate(name, opts)]
  end

  # JSXOpeningElement

  defp do_generate(%JSXOpeningElement{name: name, attributes: attributes, selfClosing: self_closing}, %{wh_sep: wh_sep} = opts) do
    self_closing = if self_closing, do: [wh_sep, "/"], else: ""
    attributes_value = cond do
      Enum.empty?(attributes) -> ""
      true ->
        attributes = attributes
        |> Enum.map(&do_generate(&1, opts))
        |> Enum.intersperse(" ")

        [" " | attributes]
    end

    ["<", do_generate(name, opts), attributes_value, self_closing, ">"]
  end

  # JSXSpreadAttribute

  defp do_generate(%JSXSpreadAttribute{argument: argument}, opts) do
    ["{...", do_generate(argument, opts), "}"]
  end

  # LabeledStatement

  defp do_generate(%LabeledStatement{label: label, body: body}, opts) do
    label = do_generate(label, opts)
    body = do_generate(body, opts)

    [label, ": ", body]
  end

  # Literal

  defp do_generate(%Literal{value: nil}, _opts) do
    "null"
  end

  defp do_generate(%Literal{value: %{}, regex: regex}, _opts) do
    ["/", regex.pattern, "/", regex.flags]
  end

  defp do_generate(%Literal{value: value}, _opts) when is_boolean(value) do
    to_string(value)
  end

  defp do_generate(%Literal{value: value}, _opts) when is_atom(value) do
    ["'", to_string(value), "'"]
  end

  defp do_generate(%Literal{value: value}, _opts) when is_binary(value) do
    ["'", escape_string(value), "'"]
  end

  defp do_generate(%Literal{value: value}, _opts) do
    to_string(value)
  end

  # LogicalExpression

  defp do_generate(%LogicalExpression{operator: operator, left: left, right: right} = node, %{wh_sep: wh_sep} = opts) do
    operator = do_generate(operator, opts)
    left = format_binary_expression(left, node, false, opts)
    right = format_binary_expression(right, node, true, opts)

    [left, wh_sep, operator, wh_sep, right]
  end

  # MemberExpression

  defp do_generate(%MemberExpression{object: object, property: property, computed: computed}, opts) do
    precedence = Map.get(@expressions_precedence, object.__struct__)
    object = do_generate(object, opts)

    object = if precedence < @expressions_precedence[MemberExpression] do
      ["(", object, ")"]
    else
      object
    end

    property = do_generate(property, opts)

    property = if computed do
      ["[", property, "]"]
    else
      [".", property]
    end

    [object, property]
  end

  # MetaProperty

  defp do_generate(%MetaProperty{meta: meta, property: property}, opts) do
    [do_generate(meta, opts), ".", do_generate(property, opts)]
  end

  # MethodDefinition

  defp do_generate(%MethodDefinition{key: _key, value: %FunctionExpression{params: params, defaults: defaults, body: body}, kind: :constructor}, opts) do
    params = params_and_defaults(params, defaults, opts)
    body = do_generate(body, opts)

    ["constructor(", params, ")", opts.wh_sep, body]
  end

  defp do_generate(%MethodDefinition{key: key, value: %FunctionExpression{params: params, defaults: defaults, body: body}, kind: :method, computed: false, static: false}, opts) do
    key = do_generate(key, opts)
    params = params_and_defaults(params, defaults, opts)
    body = do_generate(body, opts)

    [key, "(", params, ")", opts.wh_sep, body]
  end

  defp do_generate(%MethodDefinition{key: key, value: %FunctionExpression{params: params, defaults: defaults, body: body}, kind: :method, computed: false, static: true}, opts) do
    key = do_generate(key, opts)
    params = params_and_defaults(params, defaults, opts)
    body = do_generate(body, opts)

    ["static ", key, "(", params, ")", opts.wh_sep, body]
  end

  defp do_generate(%MethodDefinition{key: key, value: %FunctionExpression{params: params, defaults: defaults, body: body}, kind: :method, computed: true, static: false}, opts) do
    key = do_generate(key, opts)
    params = params_and_defaults(params, defaults, opts)
    body = do_generate(body, opts)

    ["[", key, "](", params, ")", opts.wh_sep, body]
  end

  defp do_generate(%MethodDefinition{key: key, value: %FunctionExpression{params: params, defaults: defaults, body: body}, kind: :method, computed: true, static: true}, opts) do
    key = generate(key, opts)
    params = params_and_defaults(params, defaults, opts)
    body = do_generate(body, opts)

    ["static [", key, "](", params, ")", opts.wh_sep, body]
  end

  defp do_generate(%MethodDefinition{key: key, value: %FunctionExpression{body: body}, kind: :get, static: true}, opts) do
    key = generate(key, opts)
    body = do_generate(body, opts)

    ["static get ", key, "()", opts.wh_sep, body]
  end

  defp do_generate(%MethodDefinition{key: key, value: %FunctionExpression{params: params, defaults: defaults, body: body}, kind: :set, static: true}, opts) do
    key = generate(key, opts)
    params = params_and_defaults(params, defaults, opts)
    body = do_generate(body, opts)

    ["static set ", key, "(", params, ")", opts.wh_sep, body]
  end

  defp do_generate(%MethodDefinition{key: key, value: %FunctionExpression{body: body}, kind: :get}, opts) do
    key = generate(key, opts)
    body = do_generate(body, opts)

    ["get ", key, "()", opts.wh_sep, body]
  end

  defp do_generate(%MethodDefinition{key: key, value: %FunctionExpression{params: params, defaults: defaults, body: body}, kind: :set}, opts) do
    key = generate(key, opts)
    params = params_and_defaults(params, defaults, opts)
    body = do_generate(body, opts)

    ["set ", key, "(", params, ")", opts.wh_sep, body]
  end

  # NewExpression

  defp do_generate(%NewExpression{callee: callee, arguments: arguments}, opts) do
    precedence = Map.get(@expressions_precedence, callee.__struct__)

    callee = if precedence < @expressions_precedence[NewExpression] or has_call_expression(callee) do
      ["(", do_generate(callee, opts), ")"]
    else
      do_generate(callee, opts)
    end

    arguments = arguments
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    ["new ", callee, "(", arguments, ")"]
  end

  # ObjectExpression

  defp do_generate(%ObjectExpression{properties: nil}, _opts) do
   "{}"
  end

  defp do_generate(%ObjectExpression{properties: []}, _opts) do
   "{}"
  end

  defp do_generate(%ObjectExpression{properties: properties}, opts) do
    close_bracket = if opts.beauty do
      ["\n", indent(opts), "}"]
    else
      "}"
    end

    opts = next_indent(opts)
    i = indent(opts)

    open_bracket = if opts.beauty do
      ["{\n", i]
    else
      "{"
    end

    sep = if opts.beauty do
      [",\n", i]
    else
      opts.comma_sep
    end

    properties = properties
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(sep)

    [open_bracket, properties, close_bracket]
  end

  # ObjectPattern

  defp do_generate(%ObjectPattern{properties: properties}, opts) do
    properties = properties
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    ["{", properties, "}"]
  end

  # Program

  defp do_generate(%Program{body: []}, _opts) do
    ""
  end

  defp do_generate(%Program{body: body}, opts) do
    sep = if opts.beauty do
      "\n\n"
    else
      ""
    end

    body
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(sep)
  end

  # Property

  defp do_generate(%Property{key: key, value: value, kind: :init, shorthand: false, method: false, computed: false}, %{colon_sep: colon_sep} = opts) do
    key = do_generate(key, opts)
    value = do_generate(value, opts)

    [key, colon_sep, value]
  end

  defp do_generate(%Property{key: key, value: _, kind: :init, shorthand: true, method: false, computed: false}, opts) do
    do_generate(key, opts)
  end

  defp do_generate(%Property{key: key, value: value, kind: :init, shorthand: false, method: false, computed: true}, %{colon_sep: colon_sep} = opts) do
    key = do_generate(key, opts)
    value = do_generate(value, opts)

    ["[", key, "]", colon_sep, value]
  end

  defp do_generate(%Property{key: key, value: %FunctionExpression{params: params, defaults: defaults, body: body}, kind: :init, shorthand: false, method: true, computed: true}, %{wh_sep: wh_sep} = opts) do
    key = do_generate(key, opts)
    params = params_and_defaults(params, defaults, opts)
    body = do_generate(body, opts)

    ["[", key, "]", "(", params, ")", wh_sep, body]
  end

  defp do_generate(%Property{key: key, value: %FunctionExpression{body: body}, kind: :get, shorthand: false, method: true, computed: false}, %{wh_sep: wh_sep} = opts) do
    key = do_generate(key, opts)
    body = do_generate(body, opts)

    [key, "()", wh_sep, body]
  end

  defp do_generate(%Property{key: key, value: %FunctionExpression{body: body}, kind: :get}, %{wh_sep: wh_sep} = opts) do
    key = do_generate(key, opts)
    body = do_generate(body, opts)

    ["get ", key, "()", wh_sep, body]
  end

  defp do_generate(%Property{key: key, value: %FunctionExpression{params: params, body: body}, kind: :set, shorthand: false, method: true, computed: false}, %{wh_sep: wh_sep} = opts) do
    key = do_generate(key, opts)
    params = do_generate(hd(params), opts)
    body = do_generate(body, opts)

    [key, "(", params, ")", wh_sep, body]
  end

  defp do_generate(%Property{key: key, value: %FunctionExpression{params: params, body: body}, kind: :set}, %{wh_sep: wh_sep} = opts) do
    key = do_generate(key, opts)
    params = do_generate(hd(params), opts)
    body = do_generate(body, opts)

    ["set ", key, "(", params, ")", wh_sep, body]
  end

  # RestElement

  defp do_generate(%RestElement{argument: argument}, opts) do
    ["...", do_generate(argument, opts)]
  end

  # ReturnStatement
  defp do_generate(%ReturnStatement{argument: nil}, _opts) do
    "return;"
  end

  defp do_generate(%ReturnStatement{argument: argument}, opts) do
    ["return ", do_generate(argument, opts), ";"]
  end

  # SequenceExpression

  defp do_generate(%SequenceExpression{expressions: expressions}, opts) do
    expressions = expressions
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)

    ["(", expressions, ")"]
  end

  # SpreadElement

  defp do_generate(%SpreadElement{argument: argument}, opts) do
    ["...", do_generate(argument, opts)]
  end

  # Super

  defp do_generate(%Super{}, _opts) do
    "super"
  end

  # SwitchCase

  defp do_generate(%SwitchCase{test: nil, consequent: consequent}, opts) do
    start_sep = if opts.beauty do
      indent(opts, 1)
    else
      ""
    end

    sep = if opts.beauty do
      ["\n", indent(opts)]
    else
      ""
    end

    consequent = consequent
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(sep)

    [start_sep, "default:", sep, consequent]
  end

  defp do_generate(%SwitchCase{test: test, consequent: consequent}, opts) do
    start_sep = if opts.beauty do
      indent(opts, 1)
    else
      ""
    end

    sep = if opts.beauty do
      ["\n", indent(opts)]
    else
      ""
    end

    test = do_generate(test, opts)

    consequent = consequent
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(sep)

    [start_sep, "case ", test, ":", sep, consequent]
  end

  # SwitchStatement

  defp do_generate(%SwitchStatement{discriminant: discriminant, cases: cases}, %{wh_sep: wh_sep} = opts) do
    open_bracket = if opts.beauty do
      "{\n"
    else
      "{"
    end

    close_bracket = if opts.beauty do
      ["\n", indent(opts), "}"]
    else
      "}"
    end

    sep = if opts.beauty do
      "\n\n"
    else
      ""
    end

    opts = next_indent(opts)

    cases = cases
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(sep)

    discriminant = do_generate(discriminant, opts)

    ["switch", wh_sep, "(", discriminant, ")", wh_sep, open_bracket, cases, close_bracket]
  end

  # TaggedTemplateExpression

  defp do_generate(%TaggedTemplateExpression{tag: tag, quasi: quasi}, opts) do
    [do_generate(tag, opts), " ", do_generate(quasi, opts)]
  end

  # TemplateLiteral

  defp do_generate(%TemplateLiteral{expressions: [], quasis: []}, _opts) do
    "``"
  end

  defp do_generate(%TemplateLiteral{expressions: [expression], quasis: []}, opts) do
    ["`${", do_generate(expression, opts), "}`"]
  end

  defp do_generate(%TemplateLiteral{expressions: [], quasis: [quasi]}, _opts) do
    ["`", escape_string(quasi.value.raw, false), "`"]
  end

  defp do_generate(%TemplateLiteral{expressions: expressions, quasis: quasis}, opts) do
    elements = expressions ++ quasis

    literal = elements
    |> Enum.sort(fn (one, two) ->
      one.loc.start.column < two.loc.start.column
    end)
    |> Enum.reduce("", fn (el, str) ->
      case el do
        %TemplateElement{} ->
          [str, escape_string(el.value.raw, false)]

        _ ->
          [str, "${", do_generate(el, opts), "}"]
      end
    end)

    ["`", literal, "`"]
  end

  # ThisExpression

  defp do_generate(%ThisExpression{}, _opts) do
    "this"
  end

  # ThrowStatement

  defp do_generate(%ThrowStatement{argument: argument}, opts) do
    ["throw ", do_generate(argument, opts), ";"]
  end

  # TryStatement

  defp do_generate(%TryStatement{block: block, handler: handler, finalizer: nil}, %{wh_sep: wh_sep} = opts) do
    block = do_generate(block, opts)
    handler = do_generate(handler, opts)

    ["try", wh_sep, block, wh_sep, handler]
  end

  defp do_generate(%TryStatement{block: block, handler: nil, finalizer: finalizer}, %{wh_sep: wh_sep} = opts) do
    block = do_generate(block, opts)
    finalizer = do_generate(finalizer, opts)

    ["try", wh_sep, block, wh_sep, "finally", wh_sep, finalizer]
  end

  defp do_generate(%TryStatement{block: block, handler: handler, finalizer: finalizer}, %{wh_sep: wh_sep} = opts) do
    block = do_generate(block, opts)
    handler = do_generate(handler, opts)
    finalizer = do_generate(finalizer, opts)

    ["try", wh_sep, block, wh_sep, handler, wh_sep, "finally", wh_sep, finalizer]
  end

  # UnaryExpression

  defp do_generate(%UnaryExpression{operator: operator, prefix: true, argument: argument}, opts) do
    precedence = Map.get(@expressions_precedence, argument.__struct__)

    sep = if operator in [:delete, :typeof, :void], do: " ", else: ""
    operator = do_generate(operator, opts)
    argument = do_generate(argument, opts)

    if precedence < @expressions_precedence[UnaryExpression] do
      [operator, sep, "(", argument, ")"]
    else
      [operator, sep, argument]
    end
  end

  defp do_generate(%UnaryExpression{operator: operator, prefix: false, argument: argument}, opts) do
    [do_generate(argument, opts), do_generate(operator, opts)]
  end

  # UpdateExpression

  defp do_generate(%UpdateExpression{operator: operator, prefix: true, argument: argument}, opts) do
    [do_generate(operator, opts), do_generate(argument, opts)]
  end

  defp do_generate(%UpdateExpression{operator: operator, prefix: false, argument: argument}, opts) do
    [do_generate(argument, opts), do_generate(operator, opts)]
  end

  # VariableDeclaration

  defp do_generate(%VariableDeclaration{kind: kind, declarations: declarations}, opts) when kind in [:var, :let, :const] do
    i = indent(next_indent(opts))
    sep = if opts.beauty do
      if kind == :const do
        [",\n", i, " "]
      else
        [",\n", i]
      end
    else
      opts.comma_sep
    end

    declarators = declarations
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(sep)

    semicolon = if opts.no_trailing_semicolon do
      ""
    else
      ";"
    end

    [to_string(kind), " ", declarators, semicolon]
  end

  # VariableDeclarator

  defp do_generate(%VariableDeclarator{id: id, init: nil}, opts) do
    do_generate(id, opts)
  end

  defp do_generate(%VariableDeclarator{id: id, init: %FunctionDeclaration{} = init}, %{wh_sep: wh_sep} = opts) do
    opts = %{next_indent(opts) | no_trailing_semicolon: true}

    [do_generate(id, opts), wh_sep, "=", wh_sep, do_generate(init, opts)]
  end

  defp do_generate(%VariableDeclarator{id: id, init: %FunctionExpression{} = init}, %{wh_sep: wh_sep} = opts) do
    opts = %{next_indent(opts) | no_trailing_semicolon: true}

    [do_generate(id, opts), wh_sep, "=", wh_sep, do_generate(init, opts)]
  end

  defp do_generate(%VariableDeclarator{id: id, init: init}, %{wh_sep: wh_sep} = opts) do
    [do_generate(id, opts), wh_sep, "=", wh_sep, do_generate(init, opts)]
  end

  # WhileStatement

  defp do_generate(%WhileStatement{test: test, body: body}, %{wh_sep: wh_sep} = opts) do
    test = do_generate(test, opts)
    body = do_generate(body, opts)

    ["while", wh_sep, "(", test, ")", wh_sep, body]
  end

  # WithStatement

  defp do_generate(%WithStatement{object: object, body: body}, %{wh_sep: wh_sep} = opts) do
    object = do_generate(object, opts)
    body = do_generate(body, opts)

    ["with", wh_sep, "(", object, ")", wh_sep, body]
  end

  # YieldExpression

  defp do_generate(%YieldExpression{argument: argument, delegate: false}, opts) do
    ["yield ", do_generate(argument, opts)]
  end

  defp do_generate(%YieldExpression{argument: argument, delegate: true}, %{wh_sep: wh_sep} = opts) do
    ["yield*", wh_sep, do_generate(argument, opts)]
  end

  # Helpers

  defp escape_string(string, escape_quotes \\ true) do
    string = string
    |> String.replace("\\", "\\\\")
    |> String.replace("\n", "\\n")
    |> String.replace("\r", "\\r")
    |> String.replace("\t", "\\t")
    |> String.replace("\b", "\\b")
    |> String.replace("\f", "\\f")
    |> String.replace("\v", "\\v")
    |> String.replace("\u2028", "\\u2028")
    |> String.replace("\u2029", "\\u2029")
    |> String.replace("\ufeff", "\\ufeff")

    if escape_quotes do
      string
      |> String.replace("\x27", "\\'")
    else
      string
    end
  end

  defp params_and_defaults(params, [], opts) do
    params
    |> Enum.map(&do_generate(&1, opts))
    |> Enum.intersperse(opts.comma_sep)
  end

  defp params_and_defaults(params, defaults, %{wh_sep: wh_sep} = opts) do
    params
    |> Enum.zip(defaults)
    |> Enum.map(fn
      {p, nil} -> do_generate(p, opts)
      {p, d}   -> [do_generate(p, opts), wh_sep, "=", wh_sep, do_generate(d, opts)]
    end)
    |> Enum.intersperse(opts.comma_sep)
  end

  defp format_binary_expression(node, node_parent, is_right_hand, opts) do
    if parenthesis(node, node_parent, is_right_hand) do
      ["(", do_generate(node, opts), ")"]
    else
      do_generate(node, opts)
    end
  end

  defp parenthesis(node, parent_node, is_right_hand) do
    node_p = @expressions_precedence[node.__struct__]
    parent_node_p = @expressions_precedence[parent_node.__struct__]

    cond do
      node_p != parent_node_p ->
        node_p < parent_node_p

      node_p != 13 and node_p != 14 ->
        false

      node.operator == :'**' and parent_node.operator == :'**' ->
        not is_right_hand

      is_right_hand ->
        @operator_precedence[node.operator] <= @operator_precedence[parent_node.operator]

      true ->
        @operator_precedence[node.operator] < @operator_precedence[parent_node.operator]
    end
  end

  defp generate_jsx_children(children, opts) do
    children
    |> Enum.map(fn
      %Literal{value: value} when is_binary(value) ->
        convert_jsx_text(value)

      other ->
        do_generate(other, opts)
    end)
  end

  defp convert_jsx_text(string) do
    string
    |> String.replace("{", "&lcub;")
    |> String.replace("}", "&rcub;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
  end

  defp indent(opts, back \\ 0) do
    String.duplicate(" ", opts.indent_start + opts.indent - back * opts.indent_level)
  end

  defp next_indent(opts) do
    %{opts | indent: opts.indent + opts.indent_level}
  end

  defp has_call_expression(node) when not is_map(node) do
    false
  end

  defp has_call_expression(node) do
    case node do
      %CallExpression{} ->
        true

      %MemberExpression{} ->
        has_call_expression(node.object)

      _ ->
        false
    end
  end
end
