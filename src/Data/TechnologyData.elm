module Data.TechnologyData exposing
    ( TechnologyType(..)
    , technology
    )

import Data.BuildingData as BuildingData exposing (Building(..))
import Data.UnitData exposing (UnitFamily, UnitFamilyType(..))
import Resources exposing (Cost, applyToFood, applyToTime)


type TechnologyType
    = Supplies
    | Conscription


type Technology
    = EconomyTech
    | UnitTech UnitTechnology


type alias UnitTechnology =
    { name : String
    , building : Building
    , selector : UnitFamily -> Bool
    , effect : Cost -> Cost
    }


technology : TechnologyType -> Technology
technology technologyType =
    case technologyType of
        Supplies ->
            supplies

        Conscription ->
            conscription


supplies : Technology
supplies =
    UnitTech <|
        UnitTechnology "Supplies"
            Barracks
            (\uf -> uf.unitFamilyType == Militia)
            (applyToFood ((-) 15))


conscription : Technology
conscription =
    let
        buildings =
            [ Barracks, ArcheryRange, Stable, Castle ]

        units =
            List.concatMap BuildingData.production buildings
    in
    UnitTech <|
        UnitTechnology "Conscription"
            Castle
            (\uf -> List.member uf.unitFamilyType units)
            (applyToTime
                ((*) (3 / 4))
            )
