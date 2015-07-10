defmodule ESTree.Tools.Builder do
  @moduledoc """
  Functions to make building the Nodes easier
  """

  @spec array_expression(
    [ESTree.Expression.t | nil], 
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ArrayExpression.t
  def array_expression(elements, loc \\ nil) do
    %ESTree.ArrayExpression{ elements: elements, loc: loc }
  end 

  @spec array_pattern(
    [ESTree.Pattern.t | nil], 
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ArrayPattern.t
  def array_pattern(elements, loc \\ nil) do
    %ESTree.ArrayPattern{ elements: elements, loc: loc }
  end 

  @spec arrow_function_expression(
    [ESTree.Pattern.t], 
    [ESTree.Expression.t], 
    ESTree.BlockStatement.t | ESTree.Expression.t,
    boolean,
    boolean,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ArrowFunctionExpression.t
  def arrow_function_expression(params, defaults, body, generator \\ false, expression \\ false, loc \\ nil) do
    %ESTree.ArrowFunctionExpression{ 
      params: params, defaults: defaults, 
      body: body, generator: generator, expression: expression, loc: loc 
    }
  end 

  @spec assignment_expression(
    ESTree.assignment_operator, 
    ESTree.Pattern.t | ESTree.Expression.t, 
    ESTree.Expression.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.AssignmentExpression.t
  def assignment_expression(operator, left, right, loc \\ nil) do
    %ESTree.AssignmentExpression{ 
      operator: operator, left: left, right: right, loc: loc
    }
  end

  @spec binary_expression(
    ESTree.binary_operator, 
    ESTree.Expression.t, 
    ESTree.Expression.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.BinaryExpression.t
  def binary_expression(operator, left, right, loc \\ nil) do
    %ESTree.BinaryExpression{ 
      operator: operator, left: left, right: right, loc: loc
    }
  end

  @spec block_statement(
    [ESTree.Statement.t],
    ESTree.SourceLocation.t | nil
  ) :: ESTree.BlockStatement.t
  def block_statement(body, loc \\ nil) do
    %ESTree.BlockStatement{ 
      body: body, loc: loc
    }
  end

  @spec break_statement(
    ESTree.Identifier.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.BreakStatement.t
  def break_statement(label \\ nil, loc \\ nil) do
    %ESTree.BreakStatement{ 
      label: label, loc: loc
    }
  end 

  @spec call_expression(
    ESTree.Expression.t,
    [ESTree.Expression.t],
    ESTree.SourceLocation.t | nil
  ) :: ESTree.CallExpression.t
  def call_expression(callee, arguments, loc \\ nil) do
    %ESTree.CallExpression{ 
      callee: callee, arguments: arguments, loc: loc
    }
  end 

  @spec catch_clause(
    ESTree.Pattern.t,
    ESTree.BlockStatement.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.CatchClause.t
  def catch_clause(param, body, loc \\ nil) do
    %ESTree.CatchClause{ 
      param: param, body: body, loc: loc
    }
  end 

  @spec class_body(
    [ESTree.MethodDefinition.t],
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ClassBody.t
  def class_body(body, loc \\ nil) do
    %ESTree.ClassBody{ 
      body: body, loc: loc
    }
  end 

  @spec class_declaration(
    ESTree.Identifier.t,
    ESTree.ClassBody.t,
    ESTree.Expression.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ClassDeclaration.t
  def class_declaration(id, body, superClass \\ nil, loc \\ nil) do
    %ESTree.ClassDeclaration{ 
      id: id, body: body, loc: loc, superClass: superClass
    }
  end  

  @spec class_expression(
    ESTree.ClassBody.t,
    ESTree.Expression.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ClassExpression.t
  def class_expression(body, superClass \\ nil,  loc \\ nil) do
    %ESTree.ClassExpression{ 
      body: body, loc: loc, superClass: superClass
    }
  end 

  @spec conditional_statement(
    ESTree.Expression.t,
    ESTree.Expression.t,
    ESTree.Expression.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ConditionalStatement.t
  def conditional_statement(test, alternate, consequent, loc \\ nil) do
    %ESTree.ConditionalStatement{ 
      test: test, alternate: alternate, consequent: consequent, loc: loc
    }
  end

  @spec continue_statement(
    ESTree.Identifier.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ContinueStatement.t
  def continue_statement(label, loc \\ nil) do
    %ESTree.ContinueStatement{ 
      label: label, loc: loc
    }
  end 

  @spec debugger_statement(
    ESTree.SourceLocation.t | nil
  ) :: ESTree.DebuggerStatement.t
  def debugger_statement(loc \\ nil) do
    %ESTree.DebuggerStatement{ 
      loc: loc
    }
  end

  @spec do_while_statement(
    ESTree.Statement.t,
    ESTree.Expression.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.DoWhileStatement.t
  def do_while_statement(body, test, loc \\ nil) do
    %ESTree.DoWhileStatement{ 
      body: body, test: test, loc: loc
    }
  end

  @spec empty_expression(
    ESTree.SourceLocation.t | nil
  ) :: ESTree.EmptyExpression.t
  def empty_expression(loc \\ nil) do
    %ESTree.EmptyExpression{ 
      loc: loc
    }
  end 

  @spec empty_statement(
    ESTree.SourceLocation.t | nil
  ) :: ESTree.EmptyStatement.t
  def empty_statement(loc \\ nil) do
    %ESTree.EmptyStatement{ 
      loc: loc
    }
  end

  @spec export_all_declaration(
    ESTree.Identifier.t | nil,                          
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ExportAllDeclaration.t
  def export_all_declaration(source \\ nil, loc \\ nil) do
    %ESTree.ExportAllDeclaration{ 
      loc: loc, source: source
    }
  end

  @spec export_declaration(
    ESTree.Declaration.t,
    [ESTree.ExportSpecifier.t | ESTree.ExportBatchSpecifier.t],
    boolean,
    ESTree.Identifier.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ExportDeclaration.t
  def export_declaration(declaration, specifiers \\ [], default \\ false, source \\ nil, loc \\ nil) do
    %ESTree.ExportDeclaration{ 
      declaration: declaration, specifiers: specifiers, default: default, source: source, loc: loc
    }
  end

  @spec export_default_declaration(
    ESTree.Declaration.t | ESTree.Expression.t,                
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ExportDefaultDeclaration.t
  def export_default_declaration(declaration \\ nil, loc \\ nil) do
    %ESTree.ExportDefaultDeclaration{ 
      loc: loc, declaration: declaration
    }
  end

  @spec export_named_declaration(
    ESTree.Declaration.t | nil,
    [ESTree.ExportSpecifier],
    ESTree.Literal.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ExportNamedDeclaration.t
  def export_named_declaration(declaration, specifiers \\ [], source \\ nil, loc \\ nil) do
    %ESTree.ExportNamedDeclaration{ 
      declaration: declaration, specifiers: specifiers,
      source: source, loc: loc
    }
  end

  @spec export_specifier(
    ESTree.Identifier.t,
    ESTree.Identifier.t | nil,    
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ExportSpecifier.t
  def export_specifier(exported, local \\ nil, loc \\ nil) do
    %ESTree.ExportSpecifier{ 
      local: local, exported: exported, loc: loc
    }
  end

  @spec expression_statement(
    ESTree.Expression.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ExpressionStatement.t
  def expression_statement(expression, loc \\ nil) do
    %ESTree.ExpressionStatement{ 
      expression: expression, loc: loc
    }
  end

  @spec for_in_statement(
    ESTree.VariableDeclaration.t | ESTree.Expression.t,
    ESTree.Expression.t,
    ESTree.Statement.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ForInStatement.t
  def for_in_statement(left, right, body, loc \\ nil) do
    %ESTree.ForInStatement{ 
      left: left, right: right, body: body, loc: loc
    }
  end

  @spec for_of_statement(
    ESTree.VariableDeclaration.t | ESTree.Expression.t,
    ESTree.Expression.t,
    ESTree.Statement.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ForOfStatement.t
  def for_of_statement(left, right, body, loc \\ nil) do
    %ESTree.ForOfStatement{ 
      left: left, right: right, body: body, loc: loc
    }
  end

  @spec for_statement(
    ESTree.VariableDeclaration.t | ESTree.Expression.t,
    ESTree.Expression.t | nil,
    ESTree.Expression.t | nil,
    ESTree.Statement.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ForStatement.t
  def for_statement(init, test, update, body, loc \\ nil) do
    %ESTree.ForStatement{ 
      init: init, test: test, update: update, body: body, loc: loc
    }
  end

  @spec function_declaration(
    ESTree.Identifier.t,
    [ESTree.Pattern.t], 
    [ESTree.Expression.t], 
    ESTree.BlockStatement.t,
    boolean,
    boolean,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.FunctionDeclaration.t
  def function_declaration(id, params, defaults, body, generator \\ false, expression \\ false, loc \\ nil) do
    %ESTree.FunctionDeclaration{ 
      id: id, params: params, defaults: defaults, 
      body: body, generator: generator,
      expression: expression, loc: loc 
    }
  end 

  @spec function_expression(
    [ESTree.Pattern.t], 
    [ ESTree.Expression.t ],
    ESTree.BlockStatement.t,
    boolean,
    boolean,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.FunctionExpression.t
  def function_expression(params, defaults, body, generator \\ false, expression \\ false, loc \\ nil) do
    %ESTree.FunctionExpression{ 
      params: params, defaults: defaults,
      body: body, generator: generator,
      expression: expression, loc: loc 
    }
  end 

  @spec identifier(
    binary,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.Identifier.t
  def identifier(name, loc \\ nil) do
    %ESTree.Identifier{ 
      name: name, loc: loc
    }
  end

  @spec if_statement(
    ESTree.Expression.t,
    ESTree.Statement.t,
    ESTree.Statement.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.IfStatement.t
  def if_statement(test, consequent, alternate \\ nil, loc \\ nil) do
    %ESTree.IfStatement{ 
      test: test, consequent: consequent, alternate: alternate, loc: loc
    }
  end

  @spec import_declaration(
    [ESTree.ImportSpecifier.t | ESTree.ImportNamespaceSpecifier.t | ESTree.ImportDefaultSpecifier.t],
    ESTree.Identifier.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ImportDeclaration.t
  def import_declaration(specifiers, source \\ nil, loc \\ nil) do
    %ESTree.ImportDeclaration{ 
      specifiers: specifiers, source: source, loc: loc
    }
  end

  @spec import_default_specifier(
    ESTree.Identifier.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ImportDefaultSpecifier.t
  def import_default_specifier(local, loc \\ nil) do
    %ESTree.ImportDefaultSpecifier{ 
      local: local, loc: loc
    }
  end

  @spec import_namespace_specifier(
    ESTree.Identifier.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ImportNamespaceSpecifier.t
  def import_namespace_specifier(local, loc \\ nil) do
    %ESTree.ImportNamespaceSpecifier{ 
      local: local, loc: loc
    }
  end

  @spec import_specifier(
    ESTree.Identifier.t,
    ESTree.Identifier.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ImportSpecifier.t
  def import_specifier(imported, local \\ nil, loc \\ nil) do
    %ESTree.ImportSpecifier{ 
      local: local, imported: imported, loc: loc
    }
  end

  @spec labeled_statement(
    ESTree.Identifier.t,
    ESTree.Statement.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.LabeledStatement.t
  def labeled_statement(label, body, loc \\ nil) do
    %ESTree.LabeledStatement{ 
      label: label, body: body, loc: loc
    }
  end

  @spec literal(
    binary | boolean | number | nil,
    ESTree.Regex.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.Literal.t
  def literal(value, regex \\ nil, loc \\ nil) do
    %ESTree.Literal{ 
      value: value, regex: regex, loc: loc
    }
  end

  @spec logical_expression(
    ESTree.logical_operator, 
    ESTree.Expression.t, 
    ESTree.Expression.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.LogicalExpression.t
  def logical_expression(operator, left, right, loc \\ nil) do
    %ESTree.LogicalExpression{ 
      operator: operator, left: left, right: right, loc: loc
    }
  end

  @spec member_expression(
     ESTree.Expression.t | ESTree.Super.t, 
    ESTree.Identifier.t | ESTree.Expression.t,
    boolean,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.MemberExpression.t
  def member_expression(object, property, computed \\ false, loc \\ nil) do
    %ESTree.MemberExpression{ 
      object: object, property: property, computed: computed, loc: loc
    }
  end

  @spec meta_property(
    ESTree.Identifier.t, 
    ESTree.Identifier.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.MetaProperty.t
  def meta_property(meta, property, loc \\ nil) do
    %ESTree.MetaProperty{ 
      meta: meta, property: property, loc: loc
    }
  end

  @spec method_definition(
    ESTree.Identifier.t, 
    ESTree.FunctionExpression.t,
    :constructor | :method | :get | :set,
    boolean,
    boolean,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.MethodDefinition.t
  def method_definition(key, value, kind \\ :method, computed \\ false, static \\ false, loc \\ nil) do
    %ESTree.MethodDefinition{ 
      key: key, value: value, kind: kind, computed: computed, static: static, loc: loc
    }
  end

  @spec new_expression(
    ESTree.Expression.t,
    [ESTree.Expression.t],
    ESTree.SourceLocation.t | nil
  ) :: ESTree.NewExpression.t
  def new_expression(callee, arguments, loc \\ nil) do
    %ESTree.NewExpression{ 
      callee: callee, arguments: arguments, loc: loc
    }
  end

  @spec object_expression(
    [ESTree.Property.t],
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ObjectExpression.t
  def object_expression(properties, loc \\ nil) do
    %ESTree.ObjectExpression{ 
      properties: properties, loc: loc
    }
  end 

  @spec object_pattern(
    [ESTree.Property.t],
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ObjectPattern.t
  def object_pattern(properties, loc \\ nil) do
    %ESTree.ObjectPattern{ 
      properties: properties, loc: loc
    }
  end 

  @spec position(
    pos_integer,
    non_neg_integer
  ) :: ESTree.Position.t
  def position(line, column) do
    %ESTree.Position{ 
      line: line, column: column
    }
  end

  @spec program(
    [ESTree.Statement.t],
    :script | :module,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.Program.t
  def program(body, sourceType \\ :script, loc \\ nil) do
    %ESTree.Program{ 
      body: body, loc: loc, sourceType: sourceType
    }
  end

  @spec property(
    ESTree.Expression.t, 
    ESTree.Expression.t ,
    :init | :get | :set,
    boolean,
    boolean,
    boolean,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.Property.t
  def property(key, value, kind \\ :init, method \\ false, shorthand \\ false, computed \\false, loc \\ nil) do
    %ESTree.Property{ 
      key: key, value: value,
      kind: kind, shorthand: shorthand, method: method,
      loc: loc, computed: computed
    }
  end

  @spec regex(
    binary,
    binary
  ) :: ESTree.Regex.t
  def regex(pattern, flags) do
    %ESTree.Regex{ 
      pattern: pattern, flags: flags
    }
  end

  @spec rest_element(
    ESTree.Expression.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.RestElement.t
  def rest_element(argument, loc \\ nil) do
    %ESTree.RestElement{ 
      argument: argument, loc: loc
    }
  end

  @spec return_statement(
    ESTree.Expression.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ReturnStatement.t
  def return_statement(argument, loc \\ nil) do
    %ESTree.ReturnStatement{ 
      argument: argument, loc: loc
    }
  end

  @spec sequence_expression(
    [ESTree.Expression.t],
    ESTree.SourceLocation.t | nil
  ) :: ESTree.SequenceExpression.t
  def sequence_expression(expressions, loc \\ nil) do
    %ESTree.SequenceExpression{ 
      expressions: expressions, loc: loc
    }
  end

  @spec source_location(
    binary | nil,
    ESTree.Position.t,
    ESTree.Position.t
  ) :: ESTree.SourceLocation.t
  def source_location(source, start, the_end) do
    %ESTree.SourceLocation{ 
      source: source, start: start, end: the_end
    }
  end

  @spec spread_element(
    ESTree.Expression.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.SpreadElement.t
  def spread_element(argument, loc \\ nil) do
    %ESTree.SpreadElement{ 
      argument: argument, loc: loc
    }
  end

  @spec super(
    ESTree.SourceLocation.t | nil
  ) :: ESTree.Super.t
  def super(loc \\ nil) do
    %ESTree.Super{ 
      loc: loc
    }
  end

  @spec switch_case(
    ESTree.Expression.t | nil,
    [ESTree.Statement.t],
    ESTree.SourceLocation.t | nil
  ) :: ESTree.SwitchCase.t
  def switch_case(test, consequent, loc \\ nil) do
    %ESTree.SwitchCase{ 
      test: test, consequent: consequent, loc: loc
    }
  end

  @spec switch_statement(
    ESTree.Expression.t,
    [ESTree.SwitchCase.t],
    ESTree.SourceLocation.t | nil
  ) :: ESTree.SwitchStatement.t
  def switch_statement(discriminant, cases, loc \\ nil) do
    %ESTree.SwitchStatement{ 
      discriminant: discriminant, cases: cases, loc: loc
    }
  end

  @spec tagged_template_expression(
    ESTree.Expression.t,
    ESTree.TemplateLiteral.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.TaggedTemplateExpression.t
  def tagged_template_expression(tag, quasi, loc \\ nil) do
    %ESTree.TaggedTemplateExpression{ 
      tag: tag, quasi: quasi, loc: loc
    }
  end

  @spec template_element(
    binary,
    binary,
    boolean,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.TemplateElement.t
  def template_element(cooked_value, raw_value, tail, loc \\ nil) do
    %ESTree.TemplateElement{ 
      value: %{cooked: cooked_value, raw: raw_value}, tail: tail, loc: loc
    }
  end

  @spec template_literal(
    [ESTree.TemplateElement.t],
    [ESTree.Expression.t],
    ESTree.SourceLocation.t | nil
  ) :: ESTree.TemplateLiteral.t
  def template_literal(quasis, expressions, loc \\ nil) do
    %ESTree.TemplateLiteral{ 
      quasis: quasis, expressions: expressions, loc: loc
    }
  end

  @spec this_expression(
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ThisExpression.t
  def this_expression(loc \\ nil) do
    %ESTree.ThisExpression{ 
      loc: loc
    }
  end

  @spec throw_statement(
    ESTree.Expression.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.ThrowStatement.t
  def throw_statement(argument, loc \\ nil) do
    %ESTree.ThrowStatement{ 
      argument: argument, loc: loc
    }
  end

  @spec try_statement(
    ESTree.BlockStatement.t,
    ESTree.CatchClause.t | nil,
    ESTree.BlockStatement.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.TryStatement.t
  def try_statement(block, handler, finalizer \\ nil, loc \\ nil) do
    %ESTree.TryStatement{ 
      block: block, handler: handler, finalizer: finalizer, loc: loc
    }
  end

  @spec unary_expression(
    ESTree.unary_operator, 
    boolean, 
    ESTree.Expression.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.UnaryExpression.t
  def unary_expression(operator, prefix, argument, loc \\ nil) do
    %ESTree.UnaryExpression{ 
      operator: operator, prefix: prefix, argument: argument, loc: loc
    }
  end

  @spec update_expression(
    ESTree.update_operator, 
    ESTree.Expression.t,
    boolean, 
    ESTree.SourceLocation.t | nil
  ) :: ESTree.UpdateExpression.t
  def update_expression(operator, argument, prefix, loc \\ nil) do
    %ESTree.UpdateExpression{ 
      operator: operator, prefix: prefix, argument: argument, loc: loc
    }
  end


  @spec variable_declaration(
    [ESTree.VariableDeclarator.t], 
    :var | :let | :const,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.VariableDeclaration.t
  def variable_declaration(declarations, kind \\ :var, loc \\ nil) do
    %ESTree.VariableDeclaration{ 
      declarations: declarations, kind: kind, loc: loc
    }
  end

  @spec variable_declarator(
    ESTree.Pattern.t, 
    ESTree.Expression.t | nil,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.VariableDeclarator.t
  def variable_declarator(id, init \\ nil, loc \\ nil) do
    %ESTree.VariableDeclarator{ 
      id: id, init: init, loc: loc
    }
  end

  @spec while_statement(
    ESTree.Expression.t, 
    ESTree.Statement.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.WhileStatement.t
  def while_statement(test, body, loc \\ nil) do
    %ESTree.WhileStatement{ 
      test: test, body: body, loc: loc
    }
  end

  @spec with_statement(
    ESTree.Expression.t, 
    ESTree.Statement.t,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.WithStatement.t
  def with_statement(object, body, loc \\ nil) do
    %ESTree.WithStatement{ 
      object: object, body: body, loc: loc
    }
  end

  @spec yield_expression(
    ESTree.Expression.t | nil,
    boolean,
    ESTree.SourceLocation.t | nil
  ) :: ESTree.YieldExpression.t
  def yield_expression(argument \\ nil, delegate \\ false,  loc \\ nil) do
    %ESTree.YieldExpression{ 
      argument: argument, loc: loc, delegate: delegate
    }
  end
end
