module Main where

import Prelude

import Effect.Uncurried (mkEffectFn1)
import React.Basic (ReactComponent, react)
import React.Basic.DOM as R

type ExampleProps =
  { label :: String
  }

type ExampleState =
  { counter :: Int
  }

example :: ReactComponent ExampleProps
example = react
  { displayName: "example"
  , initialState
  , receiveProps
  , render
  }
  where
    initialState :: ExampleState
    initialState = { counter: 0 }
    receiveProps _ _ _ = pure unit

    render { label } { counter } setState =
      let
        hello =
          R.h1 { children: [ R.text "Hello World" ]}
        button =
          R.button
            { onClick: mkEffectFn1 \_ -> do
                setState \s -> { counter: s.counter + 1 }
            , children:
                [ R.text (label <> ": " <> show counter)
                ]
            }
      in
        R.div
          { children:
              [ hello
              , button
              ]
          }
