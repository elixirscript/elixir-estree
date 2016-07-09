defmodule ESTree do
  @moduledoc """
  Defines structs that represent the JavaScript AST nodes from the ESTree spec.

  [ESTree Spec](https://github.com/estree/estree)

  Also includes a JavaScript AST to JavaScript code generator.

      alias ESTree.Tools.Builder
      alias ESTree.Tools.Generator

      ast = Builder.array_expression([
        Builder.literal(1),
        Builder.identifier(:a)
      ])

      Generator.generate(ast)
      #"[1, a]"
  """

  @type unary_operator  ::  :- | :+ | :! | :"~" | :typeof | :void | :delete

  @type binary_operator ::  :== | :!= | :=== | :!== | :< | :<= | :> | :>= |
                            :"<<" | :">>" | :>>> | :+ | :- | :* | :/ | :% | :| |
                            :^ | :& | :in | :instanceof | :"**"

  @type logical_operator  ::  :|| | :&&

  @type assignment_operator  :: := | :"+=" | :"-=" | :"*=" | :"/=" | :"%=" |
                                :"<<=" | :">>=" | :">>>=" |
                                :"|=" | :"^=" | :"&=" | :"**="

  @type update_operator  ::  :++ | :--

  @type operator :: unary_operator | binary_operator | logical_operator | assignment_operator | update_operator
end
