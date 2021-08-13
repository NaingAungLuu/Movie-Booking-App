//
//  DummyData.swift
//  Movie Booking App
//
//  Created by Harry Jason on 05/06/2021.
//

import Foundation
class DummyData {
    static func getDummySeatPlan() -> [MovieSeatVO] {
        return [
            //A
            MovieSeatVO(title: "A", type: SEAT_TYPE_TEXT),
            MovieSeatVO(title: "1", type: SEAT_TYPE_EMPTY),
            MovieSeatVO(title: "2", type: SEAT_TYPE_EMPTY),
            MovieSeatVO(title: "3", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "4", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "5", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "6", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "7", type: SEAT_TYPE_EMPTY),
            MovieSeatVO(title: "8", type: SEAT_TYPE_EMPTY),
            MovieSeatVO(title: "A", type: SEAT_TYPE_TEXT),
            //B
            MovieSeatVO(title: "B", type: SEAT_TYPE_TEXT),
            MovieSeatVO(title: "1", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "2", type: SEAT_TYPE_EMPTY),
            MovieSeatVO(title: "3", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "4", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "5", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "6", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "7", type: SEAT_TYPE_EMPTY),
            MovieSeatVO(title: "8", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "B", type: SEAT_TYPE_TEXT),
            //C
            MovieSeatVO(title: "C", type: SEAT_TYPE_TEXT),
            MovieSeatVO(title: "1", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "2", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "3", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "4", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "5", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "6", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "7", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "8", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "C", type: SEAT_TYPE_TEXT),
            //D
            MovieSeatVO(title: "D", type: SEAT_TYPE_TEXT),
            MovieSeatVO(title: "1", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "2", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "3", type: SEAT_TYPE_SELECTED),
            MovieSeatVO(title: "4", type: SEAT_TYPE_SELECTED),
            MovieSeatVO(title: "5", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "6", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "7", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "8", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "D", type: SEAT_TYPE_TEXT),
            //E
            MovieSeatVO(title: "E", type: SEAT_TYPE_TEXT),
            MovieSeatVO(title: "", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "", type: SEAT_TYPE_TAKEN),
            MovieSeatVO(title: "", type: SEAT_TYPE_TAKEN),
            MovieSeatVO(title: "", type: SEAT_TYPE_TAKEN),
            MovieSeatVO(title: "", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "E", type: SEAT_TYPE_TEXT),
            //F
            MovieSeatVO(title: "F", type: SEAT_TYPE_TEXT),
            MovieSeatVO(title: "", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "4", type: SEAT_TYPE_SELECTED),
            MovieSeatVO(title: "5", type: SEAT_TYPE_SELECTED),
            MovieSeatVO(title: "6", type: SEAT_TYPE_SELECTED),
            MovieSeatVO(title: "", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "F", type: SEAT_TYPE_TEXT),
            //S
            MovieSeatVO(title: "S", type: SEAT_TYPE_TEXT),
            MovieSeatVO(title: "1", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "2", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "3", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "4", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "5", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "6", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "7", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "8", type: SEAT_TYPE_AVAILABLE),
            MovieSeatVO(title: "S", type: SEAT_TYPE_TEXT),
        ]
    }
    static func getDummyMovie() -> Movie {
        return Movie(
            name: "Pokémon : Detective Pikachu",
            category: "Mystery/Adventure",
            posterImageName: "poster_detective_pikachu",
            backdropImageName: "backdrop_detective_pikachu",
            movieLength: "1h 45m",
            rating: 4,
            tags: ["Mystery" , "Adventure"],
            plotSummary: "After the demise of his father, Tim travels to Ryme city where he runs into his father's Pokemon partner, Pikachu. They team up and try to work on the case left unfinished by Tim\'s father.",
            castImages: ["actor"]
        )
    }
    static func getNowShowingMovieList() -> [Movie] {
     return [
            Movie(
                name: "Pokémon : Detective Pikachu",
                category: "Mystery/Adventure",
                posterImageName: "poster_detective_pikachu",
                backdropImageName: "backdrop_detective_pikachu",
                movieLength: "1h 45m",
                rating: 4,
                tags: ["Mystery" , "Adventure"],
                plotSummary: "After the demise of his father, Tim travels to Ryme city where he runs into his father's Pokemon partner, Pikachu. They team up and try to work on the case left unfinished by Tim\'s father.",
                castImages: ["actor"]
            ),
            Movie(
                name: "Wonder Park",
                category: "Animation/Family",
                posterImageName: "poster_wonder_park",
                backdropImageName: "backdrop_wonder_park",
                movieLength: "1h 26m",
                rating: 4,
                tags: ["Animation" , "Family"],
                plotSummary: "After the demise of his father, Tim travels to Ryme city where he runs into his father's Pokemon partner, Pikachu. They team up and try to work on the case left unfinished by Tim\'s father.",
                castImages: ["actor"]
            ),
            Movie(
                name: "6 Underground",
                category: "Crime/Action",
                posterImageName: "poster_6_underground",
                backdropImageName: "backdrop_6_underground",
                movieLength: "1h 55m",
                rating: 4,
                tags: ["Crime" , "Action"],
                plotSummary: "After the demise of his father, Tim travels to Ryme city where he runs into his father's Pokemon partner, Pikachu. They team up and try to work on the case left unfinished by Tim\'s father.",
                castImages: ["actor"]
            ),
            Movie(
                name: "Raya",
                category: "Animation/Fantasy",
                posterImageName: "poster_raya",
                backdropImageName: "backdrop_raya",
                movieLength: "2h",
                rating: 4,
                tags: ["Animation" , "Fantasy"],
                plotSummary: "After Thanos wiped out half of the planet Earth, the remaining half of the Avengers set out a plan to fight back and avenge Thanos for their loss. And yet, Thanos is still powerful even before he has collected all the infinity stones",
                castImages: ["actor"]
            ),
            Movie(
                name: "Godzilla Vs Kong",
                category: "Action/Thriller",
                posterImageName: "poster_godzilla_vs_kong",
                backdropImageName: "backdrop_godzilla_vs_kong",
                movieLength: "1h 38m",
                rating: 4,
                tags: ["Action" , "Thriller"],
                plotSummary: "After Thanos wiped out half of the planet Earth, the remaining half of the Avengers set out a plan to fight back and avenge Thanos for their loss. And yet, Thanos is still powerful even before he has collected all the infinity stones",
                castImages: ["actor"]
            ),
        ]
    }
    
    static func getComingSoonMovieList() -> [Movie] {
     return [
            Movie(
                name: "Avengers : End Game",
                category: "Action/Sci-fi",
                posterImageName: "poster_avengers_endgame",
                backdropImageName: "backdrop_avengers_endgame",
                movieLength: "1h 25m",
                rating: 4,
                tags: ["Action" , "Sci-fi"],
                plotSummary: "After the demise of his father, Tim travels to Ryme city where he runs into his father's Pokemon partner, Pikachu. They team up and try to work on the case left unfinished by Tim\'s father.",
                castImages: ["actor"]
            ),
            Movie(
                name: "John Wick 3 - Parabellum",
                category: "Animation/Thriller",
                posterImageName: "poster_john_wick_3",
                backdropImageName: "backdrop_john_wick_3",
                movieLength: "1h 26m",
                rating: 4,
                tags: ["Action" , "Thriller"],
                plotSummary: "After the demise of his father, Tim travels to Ryme city where he runs into his father's Pokemon partner, Pikachu. They team up and try to work on the case left unfinished by Tim\'s father.",
                castImages: ["actor"]
            ),
            Movie(
                name: "Aladdin",
                category: "Animation/Fantasy",
                posterImageName: "poster_aladdin",
                backdropImageName: "backdrop_aladdin",
                movieLength: "1h 55m",
                rating: 4,
                tags: ["Animation" , "Fantasy"],
                plotSummary: "After the demise of his father, Tim travels to Ryme city where he runs into his father's Pokemon partner, Pikachu. They team up and try to work on the case left unfinished by Tim\'s father.",
                castImages: ["actor"]
            ),
            Movie(
                name: "Raya",
                category: "Animation/Fantasy",
                posterImageName: "poster_raya",
                backdropImageName: "backdrop_raya",
                movieLength: "2h",
                rating: 4,
                tags: ["Animation" , "Fantasy"],
                plotSummary: "After Thanos wiped out half of the planet Earth, the remaining half of the Avengers set out a plan to fight back and avenge Thanos for their loss. And yet, Thanos is still powerful even before he has collected all the infinity stones",
                castImages: ["actor"]
            ),
            Movie(
                name: "Godzilla Vs Kong",
                category: "Action/Thriller",
                posterImageName: "poster_godzilla_vs_kong",
                backdropImageName: "backup_godzilla_vs_kong",
                movieLength: "1h 38m",
                rating: 4,
                tags: ["Action" , "Thriller"],
                plotSummary: "After Thanos wiped out half of the planet Earth, the remaining half of the Avengers set out a plan to fight back and avenge Thanos for their loss. And yet, Thanos is still powerful even before he has collected all the infinity stones",
                castImages: ["actor"]
            ),
        ]
    }

}
