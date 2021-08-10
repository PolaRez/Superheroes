//
//  SuperheroModel.swift
//  Superheroes
//
//  Created by Polina Reznik on 04/08/2021.
//

import Foundation

struct SuperheroModel: Codable {
    let results: [Superhero]
}

struct Superhero: Codable {
    let id: String
    let name: String
    let image: AvatarImage
}

struct AvatarImage: Codable {
    let url: String
}
