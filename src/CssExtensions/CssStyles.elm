module CssExtensions.CssStyles exposing (..)

import Css exposing (..)


gridContainer : Style
gridContainer =
    batch
        [ property "display" "grid"
        , property "grid-template-columns" "20% 1fr"
        , property "grid-template-areas"
            """
            "sidebar main-content"
            """
        , property "place-items" "stretch"
        , textAlign left
        ]


sidebar : Style
sidebar =
    batch
        [ property "grid-area" "sidebar"
        , padding (px 10)
        , backgroundColor (rgb 250 200 200)
        ]
