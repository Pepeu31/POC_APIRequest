//
//  ApperanceModel.swift
//  POC_APIRequest
//
//  Created by Pedro Henrique L. Moreiras on 25/06/26.
//

import Foundation



struct Apperance: Codable {
    let gender: String
    let race: String
    let height: [String]
    let weight: [String]
    let eyeColor: String
    let hairColor: String
    
    enum CodingKeys: String, CodingKey {
           case gender, race, height, weight
           case eyeColor = "eye-color"
           case hairColor = "hair-color"
       }
}
