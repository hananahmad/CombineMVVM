//
//  ShortLinkData.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/22/22.
//

import Foundation

struct ShortLinkData: Equatable , Hashable, Codable {
    var status: Bool?
    var shortLinkResult: ShortLink?
    
//    init() {}
}

extension ShortLinkData {
    enum CodingKeys: String, CodingKey {
        case status = "ok"
        case shortLinkResult = "result"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        status = try? container?.decodeIfPresent(Bool.self, forKey: .status)
        shortLinkResult = try? container?.decodeIfPresent(ShortLink.self, forKey: .shortLinkResult)
    }
}

