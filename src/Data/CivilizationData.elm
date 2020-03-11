module Data.CivilizationData exposing
    ( Civilization
    , CivilizationData
    , all
    , civilizationData
    , civilizationDataBy
    , civilizationDatasBy
    )

import Data.TechnologyData exposing (TechnologyType(..))
import Data.UnitData exposing (BaseUnitData)


type Civilization
    = Britons
    | Byzantines
    | Chinese
    | Franks
    | Persians
    | Saracens


type alias CivilizationData =
    { civilization : Civilization
    , name : String
    , description : String
    , baseUnits : BaseUnitData
    , technologies : List TechnologyType
    }


civilizationData : Civilization -> CivilizationData
civilizationData civilization =
    case civilization of
        Britons ->
            britons

        Byzantines ->
            byzantines

        Chinese ->
            chinese

        Franks ->
            franks

        Persians ->
            persians

        Saracens ->
            saracens


civilizationDataBy : (CivilizationData -> a) -> a -> Maybe CivilizationData
civilizationDataBy f a =
    civilizationDatasBy f a
        |> List.head


civilizationDatasBy : (CivilizationData -> a) -> a -> List CivilizationData
civilizationDatasBy f a =
    all
        |> List.filter (\c -> f c == a)


all : List CivilizationData
all =
    [ britons
    , byzantines
    , chinese
    , franks
    , persians
    , saracens
    ]


britons : CivilizationData
britons =
    { civilization = Britons
    , name = "Britons"
    , description = "Centuries of overseas invasions galvanized a hardy and industrious population into a powerful juggernaut. Forge fractured kingdoms into one, defend your island from overseas incursions with disciplined yeomen levies, and set your sights far beyond your borders. Your experienced archers and Longbowmen will shower the battlefield with arrows while your siege engineers construct trebuchets capable of demolishing even the most formidable castles!"
    , baseUnits =
        { militia = 5
        , spearman = 3
        , archer = 3
        , skirmisher = 2
        }
    , technologies =
        [ Supplies
        , Conscription
        ]
    }


byzantines : CivilizationData
byzantines =
    { civilization = Byzantines
    , name = "Byzantines"
    , description = "While the Western Roman Empire decayed and collapsed, its eastern half in Byzantium remained an imperial titan for centuries to come. Repulse countless invasions with imposing fortifications, command vast and versatile armies amassed from within and outside your borders, and immolate enemy fleets with siphons of Greek Fire. Your heavily-armored Cataphracts inspire fear from the Danube to the Euphrates while your scholars propel you into a new age of technology and learning!"
    , baseUnits =
        { militia = 5
        , spearman = 3
        , archer = 3
        , skirmisher = 2
        }
    , technologies =
        [ Supplies
        , Conscription
        ]
    }


chinese : CivilizationData
chinese =
    { civilization = Chinese
    , name = "Chinese"
    , description = "Receive the Mandate of Heaven, nourish a large population with the bounty of the fertile river valleys of China, and command your people to build an empire stretching to the four corners of the earth! Guide your scholars and craftsmen towards outstanding technological discoveries and apply them to your vast armies. Will your fearsome Chu Ko Nu, armed with rapid-firing mechanical crossbows, be enough to lead your armies to victory against the wily enemies beyond your borders?"
    , baseUnits =
        { militia = 5
        , spearman = 3
        , archer = 3
        , skirmisher = 2
        }
    , technologies =
        [ Supplies
        , Conscription
        ]
    }


franks : CivilizationData
franks =
    { civilization = Franks
    , name = "Franks"
    , description = "Rule the hardy folk of the Francisca axe and establish a dynasty worthy to follow in the footsteps of the Romans! Seize the English crown, lead chivalrous knights and fierce infantry to victories as far away as the Holy Land, and construct imposing castles to defend your productive farmers from enemy incursions. The Frankish unique unit is the Throwing Axeman, a ruthless warrior whose axes spell death to anything that dares to step within range."
    , baseUnits =
        { militia = 5
        , spearman = 3
        , archer = 2
        , skirmisher = 2
        }
    , technologies =
        [ Supplies
        , Conscription
        ]
    }


persians : CivilizationData
persians =
    { civilization = Persians
    , name = "Persians"
    , description = "Emerging from inner Persia, the House of Sasan toppled feeble Parthia, establishing a dynasty capable of challenging their Roman neighbors to the west. Even after the Muslim conquest, the Sasanian legacy lived on in the structure of the medieval Persian states. Stun your enemies with a stampede of mahouted War Elephants and hails of arrows thick enough to blot out the sun while your Savaran ride them down, or field an army of gunpowder units worthy of the great Safavid Empire. Nothing is beyond your grasp!"
    , baseUnits =
        { militia = 3
        , spearman = 3
        , archer = 2
        , skirmisher = 2
        }
    , technologies =
        [ Supplies
        , Conscription
        ]
    }


saracens : CivilizationData
saracens =
    { civilization = Saracens
    , name = "Saracens"
    , description = "In the 7th century, the nomadic desert tribes of Arabia rallied around a charismatic prophet and established one of the most far-reaching and vibrant religious cultures that the world has ever seen. Lead swift cavalry and tough camelry to conquer from Iberia to India, construct strong navies to prowl the seas, and foster rich scholarship and religious contemplation. Your well-trained Mamelukes, fearsome and fearless warriors, are the only warriors strong enough to halt the advance of the dreaded Mongol hordes!"
    , baseUnits =
        { militia = 5
        , spearman = 2
        , archer = 3
        , skirmisher = 2
        }
    , technologies =
        [ Supplies
        , Conscription
        ]
    }
