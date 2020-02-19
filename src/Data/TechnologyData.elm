module Data.TechnologyData exposing
    ( Technology
    , supplies
    )

import Data.BuildingData exposing (Building(..))
import Data.UnitData exposing (UnitFamily, UnitFamilyType(..))
import Resources exposing (Cost, applyToFood)


type Technology
    = EconomyTech
    | UnitTech UnitTechnology


type alias UnitTechnology =
    { name : String
    , building : Building
    , selector : UnitFamily -> Bool
    , effect : Cost -> Cost
    }


supplies : Technology
supplies =
    UnitTech <|
        UnitTechnology "Supplies"
            Barracks
            (\uf -> uf.unitFamilyType == Militia)
            (applyToFood ((-) 15))
