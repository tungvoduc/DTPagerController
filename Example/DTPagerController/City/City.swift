//
//  City.swift
//  DTOverlayController_Example
//
//  Created by Tung Vo on 15.6.2019.
//

import Foundation

// swiftlint:disable line_length

struct City {
    var name: String
    var imageName: String
    var description: String
}

extension City {

    static var NewYork: City {
        return City(name: "New York",
                    imageName: "NewYork",
                    description: "New York, the largest city in the U.S., is an architectural marvel with plenty of historic monuments, magnificent buildings and countless dazzling skyscrapers.\nBesides the architectural delights, New York is an urban jungle that has everything to offer to visitors. The city is home to numerous museums, parks, trendy neighborhoods and shopping streets."
        )
    }

    static var SanFrancisco: City {
        return City(name: "SanFrancisco",
                    imageName: "SanFrancisco",
                    description: "San Francisco, officially the City and County of San Francisco, is a city in, and the cultural, commercial, and financial center of, Northern California. San Francisco is the 13th-most populous city in the United States, and the fourth-most populous in California, with 883,305 residents as of 2018."
        )
    }

    static var London: City {
        return City(name: "London",
                    imageName: "London",
                    description: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city."
        )
    }

    static var Amsterdam: City {
        return City(name: "Amsterdam",
                    imageName: "Amsterdam",
                    description: "Amsterdam is the Netherlands’ capital, known for its artistic heritage, elaborate canal system and narrow houses with gabled facades, legacies of the city’s 17th-century Golden Age. Its Museum District houses the Van Gogh Museum, works by Rembrandt and Vermeer at the Rijksmuseum, and modern art at the Stedelijk. Cycling is key to the city’s character, and there are numerous bike paths."
        )
    }

    static var Tokyo: City {
        return City(name: "Tokyo",
                    imageName: "Tokyo",
                    description: "Tokyo is the capital of Japan. At over 13 million people in the official metropolitan area alone, Tokyo is the core of the most populated urban area in the world, Tokyo Metropolis (which has a population of over 37 million people). This huge, wealthy and fascinating metropolis brings high-tech visions of the future side by side with glimpses of old Japan, and has something for everyone."
        )
    }

    static var Lisbon: City {
        return City(name: "Lisbon",
                    imageName: "Lisbon",
                    description: "Lisbon is Portugal’s hilly, coastal capital city. From imposing São Jorge Castle, the view encompasses the old city’s pastel-colored buildings, Tagus Estuary and Ponte 25 de Abril suspension bridge. Nearby, the National Azulejo Museum displays 5 centuries of decorative ceramic tiles. Just outside Lisbon is a string of Atlantic beaches, from Cascais to Estoril."
        )
    }

    static var Barcelona: City {
        return City(name: "Barcelona",
                    imageName: "Barcelona",
                    description: "Barcelona, the cosmopolitan capital of Spain’s Catalonia region, is known for its art and architecture. The fantastical Sagrada Família church and other modernist landmarks designed by Antoni Gaudí dot the city. Museu Picasso and Fundació Joan Miró feature modern art by their namesakes. City history museum MUHBA, includes several Roman archaeological sites."
        )
    }

    static var Stockholm: City {
        return City(name: "Stockholm",
                    imageName: "Stockholm",
                    description: "Stockholm, the capital of Sweden, encompasses 14 islands and more than 50 bridges on an extensive Baltic Sea archipelago. The cobblestone streets and ochre-colored buildings of Gamla Stan (the old town) are home to the 13th-century Storkyrkan Cathedral, the Kungliga Slottet Royal Palace and the Nobel Museum, which focuses on the Nobel Prize. Ferries and sightseeing boats shuttle passengers between the islands."
        )
    }

    static var Berlin: City {
        return City(name: "Berlin",
                    imageName: "Berlin",
                    description: "Berlin, Germany’s capital, dates to the 13th century. Reminders of the city's turbulent 20th-century history include its Holocaust memorial and the Berlin Wall's graffitied remains. Divided during the Cold War, its 18th-century Brandenburg Gate has become a symbol of reunification. The city's also known for its art scene and modern landmarks like the gold-colored, swoop-roofed Berliner Philharmonie, built in 1963."
        )
    }

    static var Bangkok: City {
        return City(name: "Bangkok",
                    imageName: "Bangkok",
                    description: "Bangkok, Thailand’s capital, is a large city known for ornate shrines and vibrant street life. The boat-filled Chao Phraya River feeds its network of canals, flowing past the Rattanakosin royal district, home to opulent Grand Palace and its sacred Wat Phra Kaew Temple. Nearby is Wat Pho Temple with an enormous reclining Buddha and, on the opposite shore, Wat Arun Temple with its steep steps and Khmer-style spire."
        )
    }

}
