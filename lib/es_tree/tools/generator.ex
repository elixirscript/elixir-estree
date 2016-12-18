defmodule ESTree.Tools.Generator do
  @moduledoc """
  Responsible for taking JavaScript AST and converting
  it to JavaScript code
  """

  @operators [
    :-, :+ , :! , :"~" , :typeof , :void , :delete,
    :== , :!= , :=== , :!== , :< , :<= , :> , :>= ,
    :"<<" , :">>" , :>>> , :+ , :- , :* , :/ , :% , :| ,
    :^ , :& , :in , :instanceof, :|| , :&&, := , :"+=" ,
    :"-=" , :"*=" , :"/=" , :"%=" , :"<<=" , :">>=" ,
    :">>>=" , :"|=" , :"^=" , :"&=", :++, :--
  ]

  @indent "    "

  @spec generate(ESTree.operator | ESTree.Node.t, integer) :: binary
  def generate(value, level \\ nil) do
    "#{do_generate(value, calculate_next_level(level))}"
  end

  def do_generate(nil, _level) do
    ""
  end

  def do_generate(operator, _level) when operator in @operators do
    to_string(operator)
  end

  def do_generate(%ESTree.Identifier{name: name}, _level) do
    to_string(name)
  end

  def do_generate(%ESTree.Literal{value: nil}, _level) do
    "null"
  end

  def do_generate(%ESTree.Literal{value: %{}, regex: regex}, _level) do
    "/#{regex.pattern}/#{regex.flags}"
  end

  def do_generate(%ESTree.Literal{value: value}, _level) when is_boolean(value) do
    "#{to_string(value)}"
  end

  def do_generate(%ESTree.Literal{value: value}, _level) when is_atom(value) do
    "'#{to_string(value)}'"
  end

  def do_generate(%ESTree.Literal{value: value}, _level) when is_binary(value) do
    value = convert_string_characters(value)

    "'#{value}'"
  end

  def do_generate(%ESTree.Literal{value: value}, _level) do
    to_string(value)
  end

  def do_generate(%ESTree.Program{body: []}, _level) do
    ""
  end

  def do_generate(%ESTree.Program{body: body}, level) do
    Enum.map_join(body, newline(level), &generate(&1, calculate_next_level(level)))
  end

  def do_generate(%ESTree.FunctionDeclaration{} = ast, level) do
    generator = if ast.generator, do: "*", else: ""
    async = if ast.async, do: "async ", else: ""

    params = params_and_defaults(ast.params, ast.defaults)
    id = generate(ast.id)

    "#{async}function#{generator} #{id}(#{params})#{generate(ast.body, calculate_next_level(level))}"
  end

  def do_generate(%ESTree.FunctionExpression{} = ast, level) do
    generator = if ast.generator, do: "*", else: ""
    async = if ast.async, do: "async ", else: ""
    params = params_and_defaults(ast.params, ast.defaults)

    "#{async}function#{generator}(#{params})#{generate(ast.body, calculate_next_level(level))}"
  end

  def do_generate(%ESTree.EmptyStatement{}, _level) do
    ";"
  end

  def do_generate(%ESTree.BlockStatement{body: body}, level) do
   "{#{newline(level)}#{indent(calculate_next_level(level))}" <> Enum.map_join(body, "#{newline(level)}#{indent(calculate_next_level(level))}", &generate(&1)) <> "#{newline(level)}#{indent(level)}}"
  end

  def do_generate(%ESTree.ExpressionStatement{expression: expression}, _level) do
    "#{generate(expression)};"
  end

  def do_generate(%ESTree.IfStatement{test: test, consequent: consequent, alternate: alternate}, level) do
    test = generate(test)
    consequent = generate(consequent, calculate_next_level(level))
    result = "if(#{test}) #{consequent}"

    if alternate do
      result <> " else #{generate(alternate, calculate_next_level(level))}"
    else
      result
    end
  end

  def do_generate(%ESTree.LabeledStatement{label: label, body: body}, level) do
    """
    #{generate(label, level)}:
    #{generate(body, calculate_next_level(level))}
    """
  end

  def do_generate(%ESTree.BreakStatement{label: nil}, _level) do
    "break;"
  end

  def do_generate(%ESTree.BreakStatement{label: label}, _level) do
    "break #{generate(label)};"
  end

  def do_generate(%ESTree.ContinueStatement{label: nil}, _level) do
    "continue;"
  end

  def do_generate(%ESTree.ContinueStatement{label: label}, _level) do
    "continue #{generate(label)};"
  end

  def do_generate(%ESTree.WithStatement{object: object, body: body}, level) do
    "with(#{generate(object)})#{generate(body, calculate_next_level(level))}"
  end

  def do_generate(%ESTree.SwitchStatement{discriminant: discriminant, cases: cases}, level) do
    cases = Enum.map_join(cases, newline(level), &generate(&1, calculate_next_level(level)))
    "switch(#{generate(discriminant)}){ #{cases} }"
  end

  def do_generate(%ESTree.ReturnStatement{argument: argument}, level) do
    "return #{generate(argument, calculate_next_level(level))};"
  end

  def do_generate(%ESTree.ThrowStatement{argument: argument}, level) do
    "throw #{generate(argument, calculate_next_level(level))};"
  end

  def do_generate(%ESTree.TryStatement{block: block, handler: handler, finalizer: nil}, level) do
    "try#{generate(block, calculate_next_level(level))}#{generate(handler, calculate_next_level(level))}"
  end

  def do_generate(%ESTree.TryStatement{block: block, handler: nil, finalizer: finalizer}, level) do
    "try#{generate(block, calculate_next_level(level))}finally#{generate(finalizer, calculate_next_level(level))}"
  end

  def do_generate(%ESTree.TryStatement{block: block, handler: handler, finalizer: finalizer}, level) do
    "try#{generate(block, calculate_next_level(level))}#{generate(handler, calculate_next_level(level))}finally#{generate(finalizer, calculate_next_level(level))}"
  end

  def do_generate(%ESTree.WhileStatement{test: test, body: body}, level) do
    "while(#{generate(test)}) #{generate(body, calculate_next_level(level))}"
  end

  def do_generate(%ESTree.DoWhileStatement{test: test, body: body}, level) do
    "do #{generate(body, calculate_next_level(level))} while(#{generate(test, level)});"
  end

  def do_generate(%ESTree.ForStatement{init: init, test: test, update: update, body: body}, level) do
    init = generate(init)
    test = generate(test)
    update = generate(update)
    body = generate(body, calculate_next_level(level))

    "for(#{init}; #{test}; #{update}) #{body}"
  end

  def do_generate(%ESTree.ForInStatement{left: left, right: right, body: body}, level) do
    left = generate(left) |> String.replace(";","")
    right = generate(right)
    body = generate(body, calculate_next_level(level))

    "for(#{left} in #{right}) #{body}"
  end

  def do_generate(%ESTree.DebuggerStatement{}, _level) do
    "debugger;"
  end

  def do_generate(%ESTree.VariableDeclaration{kind: kind, declarations: declarations}, _level) when kind in [:var, :let, :const] do

    declarators = declarations
    |> Enum.map_join(", ", fn(x) ->
      generate(x)
    end)

    "#{to_string(kind)} #{declarators};"
  end

  def do_generate(%ESTree.VariableDeclarator{id: id, init: nil}, _level) do
    generate(id)
  end

  def do_generate(%ESTree.VariableDeclarator{id: id, init: init}, _level) do
    "#{generate(id)} = #{generate(init)}"
  end

  def do_generate(%ESTree.ThisExpression{}, _level) do
    "this"
  end

  def do_generate(%ESTree.ArrayExpression{elements: nil}, _level) do
    "[]"
  end

  def do_generate(%ESTree.ArrayExpression{elements: elements}, _level) do
   "[" <> Enum.map_join(elements, ", ", &generate(&1)) <> "]"
  end

  def do_generate(%ESTree.ObjectExpression{properties: nil}, _level) do
   "{}"
  end

  def do_generate(%ESTree.ObjectExpression{properties: []}, _level) do
   "{}"
  end

  def do_generate(%ESTree.ObjectExpression{properties: properties}, level) do
    _next_level = calculate_next_level(level)
    previous_level = calculate_previous_level(level)
    key_value_separator = ",#{newline(level)}#{indent(level)}"
   "{#{newline(level)}#{indent(level)}" <> Enum.map_join(properties, key_value_separator, &generate(&1)) <> "#{newline(level)}#{indent(previous_level)}}"
  end

  def do_generate(%ESTree.Property{key: key, value: value, kind: :init, shorthand: false, method: false, computed: false}, _level) do
    key = generate(key)
    value = generate(value)

    "#{key}: #{value}"
  end

  def do_generate(%ESTree.Property{key: key, value: _, kind: :init, shorthand: true, method: false, computed: false}, _level) do
    key = generate(key)

    "#{key}"
  end

  def do_generate(%ESTree.Property{key: key, value: value, kind: :init, shorthand: false, method: false, computed: true}, _level) do
    key = generate(key)
    value = generate(value)

    "[#{key}]: #{value}"
  end

  def do_generate(%ESTree.Property{key: key, value: %ESTree.FunctionExpression{body: body}, kind: :get, shorthand: false, method: true, computed: false}, _level) do
    key = generate(key)
    value = generate(body)

    "#{key}() #{value}"
  end


  def do_generate(%ESTree.Property{key: key, value: %ESTree.FunctionExpression{body: body}, kind: :get}, _level) do
    key = generate(key)
    value = generate(body)

    "get #{key}() #{value}"
  end

  def do_generate(%ESTree.Property{key: key, value: %ESTree.FunctionExpression{params: params, body: body}, kind: :set, shorthand: false, method: true, computed: false}, _level) do
    key = generate(key)
    param = generate(hd(params))
    value = generate(body)

    "#{key}(#{param}) #{value}"
  end


  def do_generate(%ESTree.Property{key: key, value: %ESTree.FunctionExpression{params: params, body: body}, kind: :set}, _level) do
    key = generate(key)
    param = generate(hd(params))
    value = generate(body)

    "set #{key}(#{param}) #{value}"
  end

  def do_generate(%ESTree.SequenceExpression{expressions: expressions}, _level) do
    Enum.map_join(expressions, ",", &generate(&1))
  end

  def do_generate(%ESTree.UnaryExpression{operator: :typeof, prefix: true, argument: argument}, _level) do
    "#{generate(:typeof)} #{generate(argument)}"
  end

  def do_generate(%ESTree.UnaryExpression{operator: operator, prefix: true, argument: argument}, _level) do
    "#{generate(operator)}#{generate(argument)}"
  end

  def do_generate(%ESTree.UnaryExpression{operator: operator, prefix: false, argument: argument}, _level) do
    "#{generate(argument)}#{generate(operator)}"
  end

  def do_generate(%ESTree.BinaryExpression{operator: operator, left: %ESTree.BinaryExpression{} = left, right: %ESTree.BinaryExpression{} = right}, _level) do
    operator = generate(operator)
    left = generate(left)
    right = generate(right)

    "(#{left}) #{operator} (#{right})"
  end

  def do_generate(%ESTree.BinaryExpression{operator: operator, left: left, right: %ESTree.BinaryExpression{} = right}, _level) do
    operator = generate(operator)
    left = generate(left)
    right = generate(right)

    "#{left} #{operator} (#{right})"
  end

  def do_generate(%ESTree.BinaryExpression{operator: operator, left: left, right: right}, _level) do
    operator = generate(operator)
    left = generate(left)
    right = generate(right)

    "#{left} #{operator} #{right}"
  end

  def do_generate(%ESTree.AssignmentExpression{operator: operator, left: left, right: right}, _level) do
    operator = generate(operator)
    left = generate(left)
    right = generate(right)

    "#{left} #{operator} #{right}"
  end

  def do_generate(%ESTree.UpdateExpression{operator: operator, prefix: true, argument: argument}, _level) do
    "#{generate(operator)}#{generate(argument)}"
  end

  def do_generate(%ESTree.UpdateExpression{operator: operator, prefix: false, argument: argument}, _level) do
    "#{generate(argument)}#{generate(operator)}"
  end

  def do_generate(%ESTree.LogicalExpression{operator: operator, left: left, right: right}, _level) do
    operator = generate(operator)
    left = generate(left)
    right = generate(right)

    "#{left} #{operator} #{right}"
  end

  def do_generate(%ESTree.ConditionalStatement{test: test, alternate: alternate, consequent: consequent}, _level) do
    test = generate(test)
    alternate = generate(alternate)
    consequent = generate(consequent)

    "#{test} ? #{consequent} : #{alternate}"
  end

  def do_generate(%ESTree.CallExpression{callee: %ESTree.MemberExpression{ object: %ESTree.FunctionExpression{} } = callee, arguments: arguments}, level) do
    callee = generate(callee, level)
    arguments = Enum.map_join(arguments, ",", &generate(&1, level))

    "(#{callee}(#{arguments}))"
  end

  def do_generate(%ESTree.CallExpression{callee: %ESTree.Super{}, arguments: arguments}, _level) do
    arguments = Enum.map_join(arguments, ",", &generate(&1))

    "super(#{arguments})"
  end

  def do_generate(%ESTree.CallExpression{callee: callee, arguments: arguments}, level) do
    callee = generate(callee)
    arguments = Enum.map_join(arguments, ",", &generate(&1, calculate_previous_level(level)))

    "#{callee}(#{arguments})"
  end

  def do_generate(%ESTree.NewExpression{callee: callee, arguments: arguments}, _level) do
    callee = generate(callee)
    arguments = Enum.map_join(arguments, ",", &generate(&1))

    "new #{callee}(#{arguments})"
  end

  def do_generate(%ESTree.MemberExpression{object: %ESTree.Super{}, property: property, computed: true}, _level) do
    property = generate(property)
    "super[#{property}]"
  end

  def do_generate(%ESTree.MemberExpression{object: object, property: property, computed: true}, _level) do
    object = generate(object)
    property = generate(property)
    "#{object}[#{property}]"
  end

  def do_generate(%ESTree.MemberExpression{object: %ESTree.Super{}, property: property, computed: false}, _level) do
    property = generate(property)
    "super.#{property}"
  end

  def do_generate(%ESTree.MemberExpression{object: object, property: property, computed: false}, _level) do
    object = generate(object)
    property = generate(property)
    "#{object}.#{property}"
  end

  def do_generate(%ESTree.SwitchCase{test: nil, consequent: consequent}, level) do
    consequent = Enum.map_join(consequent, newline(level), &generate(&1))
    """
    default:
      #{consequent}
    """
  end

  def do_generate(%ESTree.SwitchCase{test: test, consequent: consequent}, level) do
    test = generate(test)
    consequent = Enum.map_join(consequent, newline(level), &generate(&1))

    """
    case #{test}:
      #{consequent}
    """
  end

  def do_generate(%ESTree.CatchClause{param: param, body: body}, _level) do
    param = generate(param)
    body = generate(body)

    "catch(#{param}) #{body}"
  end

  def do_generate(%ESTree.ForOfStatement{left: left, right: right, body: body}, _level) do
    left = generate(left) |> String.replace(";","")
    right = generate(right)
    body = generate(body)

    "for(#{left} of #{right}) #{body}"
  end

  def do_generate(%ESTree.SpreadElement{argument: argument}, _level) do
    "...#{generate(argument)}"
  end

  def do_generate(%ESTree.RestElement{argument: argument}, _level) do
    "...#{generate(argument)}"
  end

  def do_generate(%ESTree.ArrowFunctionExpression{} = ast, _level) do
    generator = if ast.generator
    do
      "*"
    else
      ""
    end

    params = params_and_defaults(ast.params, ast.defaults)

    "(#{params})#{generator} => #{generate(ast.body)}"
  end

  def do_generate(%ESTree.YieldExpression{argument: argument, delegate: false}, _level) do
    "yield #{generate(argument)}"
  end

  def do_generate(%ESTree.YieldExpression{argument: argument, delegate: true}, _level) do
    "yield* #{generate(argument)}"
  end

  def do_generate(%ESTree.ObjectPattern{properties: properties}, _level) do
     "{" <> Enum.map_join(properties, ",", &generate(&1)) <> "}"
  end

  def do_generate(%ESTree.AssignmentProperty{ value: value }, _) do
    value = generate(value)
    "#{value}"
  end

  def do_generate(%ESTree.ArrayPattern{elements: elements}, _level) do
     "[" <> Enum.map_join(elements, ",", &generate(&1)) <> "]"
  end

  def do_generate(%ESTree.AssignmentPattern{left: left, right: right}, _level) do
    left = generate(left)
    right = generate(right)

    "#{left} = #{right}"
  end


  def do_generate(%ESTree.ClassDeclaration{id: id, body: body, superClass: nil}, _level) do
    id = generate(id)
    body = generate(body)

    "class #{id} #{body}"
  end


  def do_generate(%ESTree.ClassDeclaration{id: id, body: body, superClass: superClass}, _level) do
    id = generate(id)
    body = generate(body)
    superClass = generate(superClass)

    "class #{id} extends #{superClass} #{body}"
  end


  def do_generate(%ESTree.ClassExpression{body: body, superClass: nil}, _level) do
    body = generate(body)

    "class #{body}"
  end


  def do_generate(%ESTree.ClassExpression{body: body, superClass: superClass}, _level) do
    body = generate(body)
    superClass = generate(superClass)

    "class extends #{superClass} #{body}"
  end

  def do_generate(%ESTree.ClassBody{body: body}, level) do
    body = Enum.map_join(body, newline(level), &generate(&1))

    "{ #{body} }"
  end

  def do_generate(%ESTree.MethodDefinition{key: _key, value: %ESTree.FunctionExpression{ params: params, defaults: defaults, body: body}, kind: :constructor}, _level) do
    params = params_and_defaults(params, defaults)
    body = generate(body)

    "constructor(#{params})#{body}"
  end

  def do_generate(%ESTree.MethodDefinition{key: key, value: %ESTree.FunctionExpression{ params: params, defaults: defaults, body: body}, kind: :method, computed: false, static: false}, _level) do
    key = generate(key)
    params = params_and_defaults(params, defaults)
    body = generate(body)

    "#{key}(#{params})#{body}"
  end

  def do_generate(%ESTree.MethodDefinition{key: key, value: %ESTree.FunctionExpression{ params: params, defaults: defaults, body: body}, kind: :method, computed: false, static: true}, _level) do
    key = generate(key)
    params = params_and_defaults(params, defaults)
    body = generate(body)

    "static #{key}(#{params})#{body}"
  end

  def do_generate(%ESTree.MethodDefinition{key: key, value: %ESTree.FunctionExpression{ params: params, defaults: defaults, body: body}, kind: :method, computed: true, static: false}, _level) do
    key = generate(key)
    params = params_and_defaults(params, defaults)
    body = generate(body)

    "[#{key}](#{params})#{body}"
  end

  def do_generate(%ESTree.MethodDefinition{key: key, value: %ESTree.FunctionExpression{ params: params, defaults: defaults, body: body}, kind: :method, computed: true, static: true}, _level) do
    key = generate(key)
    params = params_and_defaults(params, defaults)
    body = generate(body)

    "static [#{key}](#{params})#{body}"
  end

  def do_generate(%ESTree.MetaProperty{meta: meta, property: property}, _level) do
    meta = generate(meta)
    property = generate(property)

    "#{meta}.#{property}"
  end

  def do_generate(%ESTree.ImportDeclaration{specifiers: [%ESTree.ImportDefaultSpecifier{}] = specifiers, source: source}, _level) do
    specifiers = Enum.map_join(specifiers, ", ", &generate(&1))
    source = generate(source)

    "import #{specifiers} from #{source};"
  end

  def do_generate(%ESTree.ImportDeclaration{specifiers: [%ESTree.ImportNamespaceSpecifier{}] = specifiers, source: source}, _level) do
    specifiers = Enum.map_join(specifiers, ", ", &generate(&1))
    source = generate(source)

    "import #{specifiers} from #{source};"
  end

  def do_generate(%ESTree.ImportDeclaration{specifiers: specifiers, source: source}, _level) do
    specifiers = Enum.map_join(specifiers, ", ", &generate(&1))
    source = generate(source)

    "import { #{specifiers} } from #{source};"
  end


  def do_generate(%ESTree.ImportSpecifier{local: local, imported: imported}, _level) do
    local = generate(local)
    imported = generate(imported)

    if local == imported do
      "#{local}"
    else
      "#{imported} as #{local}"
    end
  end

  def do_generate(%ESTree.ImportDefaultSpecifier{local: local}, _level) do
    generate(local)
  end

  def do_generate(%ESTree.ImportNamespaceSpecifier{local: local}, _level) do
    local = generate(local)

    "* as #{local}"
  end

  def do_generate(%ESTree.ExportNamedDeclaration{declaration: %ESTree.FunctionDeclaration{} = declaration, specifiers: [], source: nil}, _level) do
     declaration = generate(declaration)
    "export #{declaration}"
  end

  def do_generate(%ESTree.ExportNamedDeclaration{declaration: declaration, specifiers: [], source: nil}, _level) do
     declaration = generate(declaration)
    "export #{declaration};"
  end

  def do_generate(%ESTree.ExportNamedDeclaration{declaration: nil, specifiers: specifiers, source: nil} = _ast, _level) do
    specifiers = Enum.map_join(specifiers, ", ", &generate(&1))

    "export { #{specifiers} };"
  end

  def do_generate(%ESTree.ExportNamedDeclaration{declaration: nil, specifiers: specifiers, source: source}, _level) do
    specifiers = Enum.map_join(specifiers, ", ", &generate(&1))
    source = generate(source)

    "export { #{specifiers} } from #{source};"
  end

  def do_generate(%ESTree.ExportSpecifier{local: local, exported: exported}, _level) do
    local = generate(local)
    exported = generate(exported)

    if local == exported do
      "#{local}"
    else
      "#{exported} as #{local}"
    end
  end

  def do_generate(%ESTree.ExportDefaultDeclaration{declaration: declaration}, _level) do
    declaration = generate(declaration)

    "export default #{declaration};"
  end

  def do_generate(%ESTree.ExportAllDeclaration{source: source}, _level) do
    source = generate(source)
    "export * from #{source};"
  end

  def do_generate(%ESTree.TaggedTemplateExpression{tag: tag, quasi: quasi}, _level) do
    tag = generate(tag)
    quasi = generate(quasi)

    "#{tag} #{quasi}"
  end

  def do_generate(%ESTree.TemplateLiteral{expressions: [], quasis: []}, _level) do
    "``"
  end

  def do_generate(%ESTree.TemplateLiteral{expressions: [expression], quasis: []}, _level) do
    expression = generate(expression)
    "`${#{expression}}`"
  end

  def do_generate(%ESTree.TemplateLiteral{expressions: [], quasis: [quasi]}, _level) do
    quasi = convert_string_characters(quasi.value.raw)
    "`#{quasi}`"
  end

  def do_generate(%ESTree.TemplateLiteral{expressions: expressions, quasis: quasis}, _level) do
    elements = expressions ++ quasis

    literal = Enum.sort(elements, fn(one, two) ->
      one.loc.start.column < two.loc.start.column
    end)
    |> Enum.reduce("", fn(el, str) ->
      case el do
        %ESTree.TemplateElement{} ->
          str <> convert_string_characters(el.value.raw)
        _ ->
          str <> "${#{generate(el)}}"
      end
    end)


    "`#{literal}`"
  end

  def do_generate(%ESTree.AwaitExpression{ argument: argument, all: _all }, _level) do
    "await #{generate(argument)}"
  end

  def do_generate(%ESTree.JSXIdentifier{ name: name }, _level) do
    "#{name}"
  end

  def do_generate(%ESTree.JSXMemberExpression{ object: object, property: property }, _level) do
    "#{ generate(object) }.#{ generate(property) }"
  end

  def do_generate(%ESTree.JSXNamespacedName{ namespace: namespace, name: name }, _level) do
    "#{ generate(namespace) }:#{ generate(name) }"
  end

  def do_generate(%ESTree.JSXEmptyExpression{}, _level) do
    ""
  end

  def do_generate(%ESTree.JSXExpressionContainer{ expression: expression }, _level) do
    "{#{ generate(expression) }}"
  end

  def do_generate(%ESTree.JSXOpeningElement{ name: name, attributes: attributes, selfClosing: selfClosing }, _level) do
    selfClosing = if selfClosing, do: "/", else: ""
    attributesValue = cond do
      Enum.empty?(attributes) -> ""
      true ->
        " #{Enum.map(attributes, &generate(&1)) |> Enum.join(" ")}"
    end
    "<#{generate(name)}#{attributesValue}#{selfClosing}>"
  end

  def do_generate(%ESTree.JSXClosingElement{ name: name }, _level) do
    "</#{ generate(name) }>"
  end

  def do_generate(%ESTree.JSXAttribute{ name: name, value: value }, _level) do
    "#{ generate(name) }=#{ generate(value) }"
  end

  def do_generate(%ESTree.JSXSpreadAttribute{ argument: argument }, _level) do
    "{...#{ generate(argument) }}"
  end

  def do_generate(%ESTree.JSXElement{ openingElement: openingElement, children: children, closingElement: closingElement }, level) do
    "#{ generate(openingElement) }#{ generate_jsx_children(children, calculate_next_level(level)) }#{ generate(closingElement) }"
  end

  defp generate_jsx_children(children, level) do
    gen_fn = fn
      %ESTree.Literal{value: value} when is_binary(value) ->
        convert_jsx_text(value)
      other ->
        generate(other, level)
    end

    children |> Enum.map(gen_fn) |> Enum.join
  end

  defp convert_jsx_text(str) do
    str
    |> String.replace("{", "&lcub;")
    |> String.replace("}", "&rcub;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
  end

  defp convert_string_characters(str) do
    String.replace(str, "\n", "\\n")
        |> String.replace("\t", "\\t")
  end

  defp params_and_defaults(params, []) do
    Enum.map_join(params, ",", &generate(&1))
  end

  defp params_and_defaults(params, defaults) do
    Enum.zip(params, defaults)
    |> Enum.map_join(",", fn
      {p, nil} -> "#{generate(p)}"
      {p, d} ->  "#{generate(p)} = #{generate(d)}"
    end)
  end

  defp indent(nil) do
    ""
  end

  defp indent(level) do
    String.duplicate("  ", level)
  end

  defp calculate_next_level(nil) do
    nil
  end

  defp calculate_next_level(level) do
    level + 1
  end

  defp calculate_previous_level(nil) do
    nil
  end

  defp calculate_previous_level(level) do
    level - 1
  end

  defp newline(nil) do
    ""
  end

  defp newline(_level) do
    "\n"
  end
end
