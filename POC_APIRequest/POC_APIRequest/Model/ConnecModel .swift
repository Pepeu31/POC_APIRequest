//
//  ConnecModel .swift
//  POC_APIRequest
//
//  Created by Pedro Henrique L. Moreiras on 25/06/26.
//

import Foundation

struct Connection: Codable {
    let groupAffiliation: String
    let relatives: String
    
    enum CodingKeys: String, CodingKey {
        case groupAffiliation = "group-affiliation"
        case relatives
    }
}
