//
//  LogoModel.swift
//  POC_APIRequest
//
//  Created by Pedro Henrique L. Moreiras on 25/06/26.
//

import Foundation

struct HeroModel: Codable {
    let response: String
    let id: String
    let name: String
    let powerstats: PowerStats
    let biography:Biography
    let appearance:Apperance
    let work: Work
    let connections: Connection
    let image:ImageM
}

