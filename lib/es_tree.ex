defmodule ESTree do
  @moduledoc """
    The SpiderMonkey AST definitions in Elixir. Mostly following the ESTree Spec. Some gaps filled in from 
    what acorn produces for ES6 currently. 

    [Parser API docs](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API)

    [ESTree Spec](https://github.com/estree/estree)
  """

  @type unary_operator  ::  :- | :+ | :! | :"~" | :typeof | :void | :delete

  @type binary_operator ::  :== | :!= | :=== | :!== | :< | :<= | :> | :>= | 
                            :"<<" | :">>" | :>>> | :+ | :- | :* | :/ | :% | :| | 
                            :^ | :& | :in | :instanceof

  @type logical_operator  ::  :|| | :&&

  @type assignment_operator  :: := | :"+=" | :"-=" | :"*=" | :"/=" | :"%=" | 
                                :"<<=" | :">>=" | :">>>=" | 
                                :"|=" | :"^=" | :"&="

  @type update_operator  ::  :++ | :--
end
