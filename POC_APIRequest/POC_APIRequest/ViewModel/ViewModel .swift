//
//  ViewModel .swift
//  POC_APIRequest
//
//  Created by Pedro Henrique L. Moreiras on 25/06/26.
//

import Foundation

func getHero() async throws -> HeroModel {
    let endpoint = "https://www.superheroapi.com/api.php/cde51f49633956fb6db9a71742b549c3/489"
    
    guard let url = URL(string: endpoint) else {
        throw HRError.invaliURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw HRError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(HeroModel.self, from: data)
    } catch {
        throw HRError.invalidData
    }
}

enum HRError: Error {
    case invaliURL
    case invalidResponse
    case invalidData
}
