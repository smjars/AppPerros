//
//  Item.swift
//  AppPerros
//
//  Created by Tardes on 21/1/25.
//

import Foundation

struct Animal: Codable, Identifiable {
    let id: Int
    let nombre: String
    let tipo: String
    let color: String
    let edad: String
    let estado: String
    let genero: String
    let desc_fisica: String
    let desc_personalidad: String
    let desc_adicional: String
    let esterilizado: Int
    let vacunas: Int
    let imagen: String
    let equipo: String
    let region: String
    let comuna: String
    let url: String
}

struct AnimalResponse: Codable {
    let data: [Animal]
}
