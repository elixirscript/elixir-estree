defmodule SpiderMonkey do
  @moduledoc """
    A Full (or near full) implementation of the SpiderMonkey Parser API in Elixir

    [Parser API docs](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API)
  """

  @type unary_operator  ::  :- | :+ | :! | :"~" | :typeof | :void | :delete

  @type binary_operator ::  :== | :!= | :=== | :!== | :< | :<= | :> | :>= | 
                            :"<<" | :">>" | :>>> | :+ | :- | :* | :/ | :% | :| | 
                            :^ | :& | :in | :instanceof | :..

  @type logical_operator  ::  :|| | :&&

  @type assignment_operator  :: := | :"+=" | :"-=" | :"*=" | :"/=" | :"%=" | 
                                :"<<=" | :">>=" | :">>>=" | 
                                :"|=" | :"^=" | :"&="

  @type update_operator  ::  :++ | :--
end
