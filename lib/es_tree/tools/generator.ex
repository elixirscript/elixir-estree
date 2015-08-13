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
  def generate(value, level \\ 0) do
    "#{indent(level)}#{do_generate(value, level + 1)}"
  end

  def do_generate(operator, level) when operator in @operators do
    to_string(operator)
  end
  
  def do_generate(%ESTree.Identifier{name: name}, level) do
    to_string(name)
  end

  def do_generate(%ESTree.Literal{value: nil}, level) do
    "null"
  end
  
  def do_generate(%ESTree.Literal{value: %{}, regex: regex}, level) do
    "/#{regex.pattern}/#{regex.flags}"
  end

  def do_generate(%ESTree.Literal{value: value}, level) when is_boolean(value) do
    "#{to_string(value)}"
  end
  
  def do_generate(%ESTree.Literal{value: value}, level) when is_atom(value) do
    "'#{to_string(value)}'"
  end
  
  def do_generate(%ESTree.Literal{value: value}, level) when is_binary(value) do
    value = convert_string_characters(value)
    
    "'#{value}'"
  end

  def do_generate(%ESTree.Literal{value: value}, level) do
    to_string(value)
  end

  def do_generate(%ESTree.Program{body: []}, level) do
    ""
  end
  
  def do_generate(%ESTree.Program{body: body}, level) do
    Enum.map_join(body, "\n", &generate(&1, level + 1))
  end

  def do_generate(%ESTree.FunctionDeclaration{} = ast, level) do
    generator = if ast.generator, do: "*", else: ""
    
    params = params_and_defaults(ast.params, ast.defaults)
    id = generate(ast.id)
    
    "function#{generator} #{id}(#{params})#{generate(ast.body, level + 1)}"
  end

  def do_generate(%ESTree.FunctionExpression{} = ast, level) do
    generator = if ast.generator, do: "*", else: ""
    params = params_and_defaults(ast.params, ast.defaults)
    
    "function#{generator}(#{params})#{generate(ast.body, level + 1)}"
  end
  
  def do_generate(%ESTree.EmptyStatement{}, level) do
    ";"
  end
  
  def do_generate(%ESTree.BlockStatement{body: body}, level) do
   "{\n#{indent(level + 1)}" <> Enum.map_join(body, "\n#{indent(level + 1)}", &generate(&1)) <> "\n#{indent(level)}}"
  end
  
  def do_generate(%ESTree.ExpressionStatement{expression: expression}, level) do
    "#{generate(expression)};"
  end

  def do_generate(%ESTree.IfStatement{test: test, consequent: consequent, alternate: alternate}, level) do
    test = generate(test)
    consequent = generate(consequent, level + 1)
    result = "if(#{test}) #{consequent}"

    if alternate do
      result = result <> " else #{generate(alternate, level + 1)}"
    end

    result
  end

  def do_generate(%ESTree.LabeledStatement{label: label, body: body}, level) do
    """
    #{generate(label, level)}:
    #{generate(body, level + 1)}
    """
  end

  def do_generate(%ESTree.BreakStatement{label: nil}, level) do
    "break;"
  end
  
  def do_generate(%ESTree.BreakStatement{label: label}, level) do
    "break #{generate(label)};"
  end

  def do_generate(%ESTree.ContinueStatement{label: nil}, level) do
    "continue;"
  end
  
  def do_generate(%ESTree.ContinueStatement{label: label}, level) do
    "continue #{generate(label)};"
  end

  def do_generate(%ESTree.WithStatement{object: object, body: body}, level) do
    "with(#{generate(object)})#{generate(body, level + 1)}"
  end

  def do_generate(%ESTree.SwitchStatement{discriminant: discriminant, cases: cases}, level) do
    cases = Enum.map_join(cases, "\n", &generate(&1, level + 1))
    "switch(#{generate(discriminant)}){ #{cases} }"
  end

  def do_generate(%ESTree.ReturnStatement{argument: argument}, level) do
    "return #{generate(argument, level + 1)};"
  end

  def do_generate(%ESTree.ThrowStatement{argument: argument}, level) do
    "throw #{generate(argument, level + 1)};"
  end

  def do_generate(%ESTree.TryStatement{block: block, handler: handler, finalizer: nil}, level) do
    "try#{generate(block, level + 1)}#{generate(handler, level + 1)}"
  end

  def do_generate(%ESTree.TryStatement{block: block, handler: nil, finalizer: finalizer}, level) do
    "try#{generate(block, level + 1)}finally#{generate(finalizer, level + 1)}"
  end
  
  def do_generate(%ESTree.TryStatement{block: block, handler: handler, finalizer: finalizer}, level) do
    "try#{generate(block, level + 1)}#{generate(handler, level + 1)}finally#{generate(finalizer, level + 1)}"
  end
  
  def do_generate(%ESTree.WhileStatement{test: test, body: body}, level) do
    "while(#{generate(test)}) #{generate(body, level + 1)}"
  end

  def do_generate(%ESTree.DoWhileStatement{test: test, body: body}, level) do
    "do #{generate(body, level + 1)} while(#{generate(test, level)});"
  end

  def do_generate(%ESTree.ForStatement{init: init, test: test, update: update, body: body}, level) do
    init = generate(init)
    test = generate(test)
    update = generate(update)
    body = generate(body, level + 1)

    "for(#{init}; #{test}; #{update}) #{body}"
  end

  def do_generate(%ESTree.ForInStatement{left: left, right: right, body: body}, level) do
    left = generate(left) |> String.replace(";","")
    right = generate(right)
    body = generate(body, level + 1)

    "for(#{left} in #{right}) #{body}"
  end

  def do_generate(%ESTree.DebuggerStatement{}, level) do
    "debugger;"
  end

  def do_generate(%ESTree.VariableDeclaration{kind: kind, declarations: [declaration]}, level) when kind in [:var, :let, :const] do
    declaration = generate(declaration)

    "#{to_string(kind)} #{declaration};"
  end
  
  def do_generate(%ESTree.VariableDeclaration{kind: kind, declarations: declarations}, level) when kind in [:var, :let, :const] do

    ids = Enum.map_join(declarations, ",",  fn(x) -> generate(x.id) end)
    inits = Enum.map_join(declarations, ",", fn(x) -> generate(x.init) end) 

    "#{to_string(kind)} #{ids} = #{inits};"
  end

  def do_generate(%ESTree.VariableDeclarator{id: id, init: nil}, level) do
    generate(id)
  end
  
  def do_generate(%ESTree.VariableDeclarator{id: id, init: init}, level) do
    "#{generate(id)} = #{generate(init)}"
  end

  def do_generate(%ESTree.ThisExpression{}, level) do
    "this"
  end

  def do_generate(%ESTree.ArrayExpression{elements: nil}, level) do
    "[]"
  end
  
  def do_generate(%ESTree.ArrayExpression{elements: elements}, level) do
   "[" <> Enum.map_join(elements, ", ", &generate(&1)) <> "]"
  end

  def do_generate(%ESTree.ObjectExpression{properties: nil}, level) do
   "{}"
  end

  def do_generate(%ESTree.ObjectExpression{properties: []}, level) do
   "{}"
  end
  
  def do_generate(%ESTree.ObjectExpression{properties: properties}, level) do
   "{\n#{indent(level + 1)}" <> Enum.map_join(properties, ", ", &generate(&1, level + 1)) <> "\n#{indent(level)}}"
  end

  def do_generate(%ESTree.Property{key: key, value: value, kind: :init, shorthand: false, method: false, computed: false}, level) do
    key = generate(key)
    value = generate(value)

    "#{key}: #{value}"
  end

  def do_generate(%ESTree.Property{key: key, value: _, kind: :init, shorthand: true, method: false, computed: false}, level) do
    key = generate(key)

    "#{key}"
  end

  def do_generate(%ESTree.Property{key: key, value: value, kind: :init, shorthand: false, method: false, computed: true}, level) do
    key = generate(key)
    value = generate(value)

    "[#{key}]: #{value}"
  end

  def do_generate(%ESTree.Property{key: key, value: %ESTree.FunctionExpression{body: body}, kind: :get, shorthand: false, method: true, computed: false}, level) do
    key = generate(key)
    value = generate(body)

    "#{key}() #{value}"
  end

  
  def do_generate(%ESTree.Property{key: key, value: %ESTree.FunctionExpression{body: body}, kind: :get}, level) do
    key = generate(key)
    value = generate(body)

    "get #{key}() #{value}"
  end

  def do_generate(%ESTree.Property{key: key, value: %ESTree.FunctionExpression{params: params, body: body}, kind: :set, shorthand: false, method: true, computed: false}, level) do
    key = generate(key)
    param = generate(hd(params))
    value = generate(body)

    "#{key}(#{param}) #{value}"
  end

  
  def do_generate(%ESTree.Property{key: key, value: %ESTree.FunctionExpression{params: params, body: body}, kind: :set}, level) do
    key = generate(key)
    param = generate(hd(params))
    value = generate(body)

    "set #{key}(#{param}) #{value}"
  end

  def do_generate(%ESTree.SequenceExpression{expressions: expressions}, level) do
    Enum.map_join(expressions, ",", &generate(&1))
  end

  def do_generate(%ESTree.UnaryExpression{operator: operator, prefix: true, argument: argument}, level) do
    "#{generate(operator)}#{generate(argument)}"
  end

  def do_generate(%ESTree.UnaryExpression{operator: operator, prefix: false, argument: argument}, level) do
    "#{generate(argument)}#{generate(operator)}"
  end
  
  def do_generate(%ESTree.BinaryExpression{operator: operator, left: %ESTree.BinaryExpression{} = left, right: %ESTree.BinaryExpression{} = right}, level) do
    operator = generate(operator)
    left = generate(left)
    right = generate(right)

    "(#{left}) #{operator} (#{right})"
  end
  
  def do_generate(%ESTree.BinaryExpression{operator: operator, left: left, right: %ESTree.BinaryExpression{} = right}, level) do
    operator = generate(operator)
    left = generate(left)
    right = generate(right)

    "#{left} #{operator} (#{right})"
  end
  
  def do_generate(%ESTree.BinaryExpression{operator: operator, left: left, right: right}, level) do
    operator = generate(operator)
    left = generate(left)
    right = generate(right)

    "#{left} #{operator} #{right}"
  end

  def do_generate(%ESTree.AssignmentExpression{operator: operator, left: left, right: right}, level) do
    operator = generate(operator)
    left = generate(left)
    right = generate(right)

    "#{left} #{operator} #{right}"
  end

  def do_generate(%ESTree.UpdateExpression{operator: operator, prefix: true, argument: argument}, level) do
    "#{generate(operator)}#{generate(argument)}"
  end

  def do_generate(%ESTree.UpdateExpression{operator: operator, prefix: false, argument: argument}, level) do
    "#{generate(argument)}#{generate(operator)}"
  end

  def do_generate(%ESTree.LogicalExpression{operator: operator, left: left, right: right}, level) do
    operator = generate(operator)
    left = generate(left)
    right = generate(right)

    "#{left} #{operator} #{right}"
  end

  def do_generate(%ESTree.ConditionalStatement{test: test, alternate: alternate, consequent: consequent}, level) do
    test = generate(test)
    alternate = generate(alternate)
    consequent = generate(consequent)

    "#{test} ? #{consequent} : #{alternate}"
  end

  def do_generate(%ESTree.CallExpression{callee: %ESTree.MemberExpression{ object: %ESTree.FunctionExpression{} } = callee, arguments: arguments}, level) do
    callee = generate(callee)
    arguments = Enum.map_join(arguments, ",", &generate(&1))

    "(#{callee}(#{arguments}))"
  end

  def do_generate(%ESTree.CallExpression{callee: %ESTree.Super{}, arguments: arguments}, level) do
    arguments = Enum.map_join(arguments, ",", &generate(&1))

    "super(#{arguments})"
  end
  
  def do_generate(%ESTree.CallExpression{callee: callee, arguments: arguments}, level) do
    callee = generate(callee)
    arguments = Enum.map_join(arguments, ",", &generate(&1))

    "#{callee}(#{arguments})"
  end

  def do_generate(%ESTree.NewExpression{callee: callee, arguments: arguments}, level) do
    callee = generate(callee)
    arguments = Enum.map_join(arguments, ",", &generate(&1))

    "new #{callee}(#{arguments})"
  end

  def do_generate(%ESTree.MemberExpression{object: %ESTree.Super{}, property: property, computed: true}, level) do
    property = generate(property)
    "super[#{property}]"
  end

  def do_generate(%ESTree.MemberExpression{object: object, property: property, computed: true}, level) do
    object = generate(object)
    property = generate(property)
    "#{object}[#{property}]"
  end

  def do_generate(%ESTree.MemberExpression{object: %ESTree.Super{}, property: property, computed: false}, level) do
    property = generate(property)
    "super.#{property}"
  end
  
  def do_generate(%ESTree.MemberExpression{object: object, property: property, computed: false}, level) do
    object = generate(object)
    property = generate(property)
    "#{object}.#{property}"
  end

  def do_generate(%ESTree.SwitchCase{test: nil, consequent: consequent}, level) do
    consequent = Enum.map_join(consequent, "\n", &generate(&1))
    """
    default:
      #{consequent}
    """
  end
  
  def do_generate(%ESTree.SwitchCase{test: test, consequent: consequent}, level) do
    test = generate(test)
    consequent = Enum.map_join(consequent, "\n", &generate(&1))

    """
    case #{test}:
      #{consequent}
    """
  end

  def do_generate(%ESTree.CatchClause{param: param, body: body}, level) do
    param = generate(param)
    body = generate(body)

    "catch(#{param}) #{body}"
  end

  def do_generate(%ESTree.ForOfStatement{left: left, right: right, body: body}, level) do
    left = generate(left) |> String.replace(";","")
    right = generate(right)
    body = generate(body)

    "for(#{left} of #{right}) #{body}"
  end

  def do_generate(%ESTree.SpreadElement{argument: argument}, level) do
    "...#{generate(argument)}"
  end

  def do_generate(%ESTree.RestElement{argument: argument}, level) do
    "...#{generate(argument)}"
  end

  def do_generate(%ESTree.ArrowFunctionExpression{} = ast, level) do
    generator = if ast.generator
    do
      "*"
    else
      ""
    end
    
    params = params_and_defaults(ast.params, ast.defaults)
    
    "(#{params})#{generator} => #{generate(ast.body)}"
  end

  def do_generate(%ESTree.YieldExpression{argument: argument}, level) do
    "yield #{generate(argument)}"
  end

  def do_generate(%ESTree.ObjectPattern{properties: properties}, level) do
     "{" <> Enum.map_join(properties, ",", &generate(&1)) <> "}"
  end

  def do_generate(%ESTree.ArrayPattern{elements: elements}, level) do
     "[" <> Enum.map_join(elements, ",", &generate(&1)) <> "]"
  end

  def do_generate(%ESTree.AssignmentPattern{left: left, right: right}, level) do
    left = generate(left)
    right = generate(right)

    "#{left} = #{right}"
  end

  
  def do_generate(%ESTree.ClassDeclaration{id: id, body: body, superClass: nil}, level) do
    id = generate(id)
    body = generate(body)

    "class #{id} #{body}"
  end

  
  def do_generate(%ESTree.ClassDeclaration{id: id, body: body, superClass: superClass}, level) do
    id = generate(id)
    body = generate(body)
    superClass = generate(superClass)

    "class #{id} extends #{superClass} #{body}"
  end


  def do_generate(%ESTree.ClassExpression{body: body, superClass: nil}, level) do
    body = generate(body)

    "class #{body}"
  end

  
  def do_generate(%ESTree.ClassExpression{body: body, superClass: superClass}, level) do
    body = generate(body)
    superClass = generate(superClass)

    "class extends #{superClass} #{body}"
  end

  def do_generate(%ESTree.ClassBody{body: body}, level) do
    body = Enum.map_join(body, "\n", &generate(&1))

    "{ #{body} }"
  end

  def do_generate(%ESTree.MethodDefinition{key: _key, value: %ESTree.FunctionExpression{ params: params, defaults: defaults, body: body}, kind: :constructor}, level) do
    params = params_and_defaults(params, defaults)
    body = generate(body)

    "constructor(#{params})#{body}"      
  end
  
  def do_generate(%ESTree.MethodDefinition{key: key, value: %ESTree.FunctionExpression{ params: params, defaults: defaults, body: body}, kind: :method, computed: false, static: false}, level) do
    key = generate(key)
    params = params_and_defaults(params, defaults)
    body = generate(body)

    "#{key}(#{params})#{body}"
  end

  def do_generate(%ESTree.MethodDefinition{key: key, value: %ESTree.FunctionExpression{ params: params, defaults: defaults, body: body}, kind: :method, computed: false, static: true}, level) do
    key = generate(key)
    params = params_and_defaults(params, defaults)
    body = generate(body)

    "static #{key}(#{params})#{body}"
  end

  def do_generate(%ESTree.MethodDefinition{key: key, value: %ESTree.FunctionExpression{ params: params, defaults: defaults, body: body}, kind: :method, computed: true, static: false}, level) do
    key = generate(key)
    params = params_and_defaults(params, defaults)
    body = generate(body)

    "[#{key}](#{params})#{body}"
  end

  def do_generate(%ESTree.MethodDefinition{key: key, value: %ESTree.FunctionExpression{ params: params, defaults: defaults, body: body}, kind: :method, computed: true, static: true}, level) do
    key = generate(key)
    params = params_and_defaults(params, defaults)
    body = generate(body)

    "static [#{key}](#{params})#{body}"
  end

  def do_generate(%ESTree.MetaProperty{meta: meta, property: property}, level) do
    meta = generate(meta)
    property = generate(property)

    "#{meta}.#{property}"
  end

  def do_generate(%ESTree.ImportDeclaration{specifiers: [%ESTree.ImportDefaultSpecifier{}] = specifiers, source: source}, level) do
    specifiers = Enum.map_join(specifiers, ", ", &generate(&1))
    source = generate(source)

    "import #{specifiers} from #{source};"
  end

  def do_generate(%ESTree.ImportDeclaration{specifiers: [%ESTree.ImportNamespaceSpecifier{}] = specifiers, source: source}, level) do
    specifiers = Enum.map_join(specifiers, ", ", &generate(&1))
    source = generate(source)

    "import #{specifiers} from #{source};"
  end
  
  def do_generate(%ESTree.ImportDeclaration{specifiers: specifiers, source: source}, level) do
    specifiers = Enum.map_join(specifiers, ", ", &generate(&1))
    source = generate(source)

    "import { #{specifiers} } from #{source};"
  end

  
  def do_generate(%ESTree.ImportSpecifier{local: local, imported: imported}, level) do
    local = generate(local)
    imported = generate(imported)

    if local == imported do
      "#{local}"
    else
      "#{imported} as #{local}"
    end
  end

  def do_generate(%ESTree.ImportDefaultSpecifier{local: local}, level) do
    generate(local)
  end

  def do_generate(%ESTree.ImportNamespaceSpecifier{local: local}, level) do
    local = generate(local)

    "* as #{local}"
  end

  def do_generate(%ESTree.ExportNamedDeclaration{declaration: %ESTree.FunctionDeclaration{} = declaration, specifiers: [], source: nil}, level) do
     declaration = generate(declaration)
    "export #{declaration}"
  end
  
  def do_generate(%ESTree.ExportNamedDeclaration{declaration: declaration, specifiers: [], source: nil}, level) do
     declaration = generate(declaration)
    "export #{declaration};"
  end
  
  def do_generate(%ESTree.ExportNamedDeclaration{declaration: nil, specifiers: specifiers, source: nil} = ast, level) do
    specifiers = Enum.map_join(specifiers, ", ", &generate(&1))

    "export { #{specifiers} };"
  end

  def do_generate(%ESTree.ExportNamedDeclaration{declaration: nil, specifiers: specifiers, source: source}, level) do
    specifiers = Enum.map_join(specifiers, ", ", &generate(&1))
    source = generate(source)
    
    "export { #{specifiers} } from #{source};"
  end
  
  def do_generate(%ESTree.ExportSpecifier{local: local, exported: exported}, level) do
    local = generate(local)
    exported = generate(exported)

    if local == exported do
      "#{local}"
    else
      "#{exported} as #{local}"
    end
  end

  def do_generate(%ESTree.ExportDefaultDeclaration{declaration: declaration}, level) do
    declaration = generate(declaration)

    "export default #{declaration};"
  end

  def do_generate(%ESTree.ExportAllDeclaration{source: source}, level) do
    source = generate(source)
    "export * from #{source};"
  end

  def do_generate(%ESTree.TaggedTemplateExpression{tag: tag, quasi: quasi}, level) do
    tag = generate(tag)
    quasi = generate(quasi)

    "#{tag} #{quasi}"
  end

  def do_generate(%ESTree.TemplateLiteral{expressions: [], quasis: []}, level) do
    "``"
  end

  def do_generate(%ESTree.TemplateLiteral{expressions: [expression], quasis: []}, level) do
    expression = generate(expression)
    "`${#{expression}}`"
  end

  def do_generate(%ESTree.TemplateLiteral{expressions: [], quasis: [quasi]}, level) do
    quasi = convert_string_characters(quasi.value.raw)
    "`#{quasi}`"
  end

  def do_generate(%ESTree.TemplateLiteral{expressions: expressions, quasis: quasis}, level) do
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

  defp indent(level) do
    String.duplicate("  ", level)
  end
end
