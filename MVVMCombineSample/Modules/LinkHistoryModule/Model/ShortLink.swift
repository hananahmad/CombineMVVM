//
//  ShortLink.swift
//  MVVMCombineSample
//
//  Created by Hanan Ahmed on 2/22/22.
//

import Foundation

struct ShortLink: Equatable, Codable {
    
    let uuid = UUID()

    var code: String?
    var shortLink: String?
    var fullShortLink: String?
    var shortLink2: String?
    var fullShortLink2: String?
    var shareLink: String?
    var fullShareLink: String?
    var originalLink: String?
    
//    init() {}
}

extension ShortLink {
    enum CodingKeys: String, CodingKey {
        case code
        case shortLink = "short_link"
        case fullShortLink = "full_short_link"
        case shortLink2 = "short_link2"
        case fullShortLink2 = "full_short_link2"
        case shareLink = "share_link"
        case fullShareLink = "full_share_link"
        case originalLink = "original_link"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        code = try? container?.decodeIfPresent(String.self, forKey: .code)
        shortLink = try? container?.decodeIfPresent(String.self, forKey: .shortLink)
        fullShortLink = try? container?.decodeIfPresent(String.self, forKey: .fullShortLink)
        shortLink2 = try? container?.decodeIfPresent(String.self, forKey: .shortLink2)
        fullShortLink2 = try? container?.decodeIfPresent(String.self, forKey: .fullShortLink2)
        shareLink = try? container?.decodeIfPresent(String.self, forKey: .shareLink)
        fullShareLink = try? container?.decodeIfPresent(String.self, forKey: .fullShareLink)
        originalLink = try? container?.decodeIfPresent(String.self, forKey: .originalLink)
    }
}

extension ShortLink : Hashable {
    static func ==(lhs: ShortLink, rhs: ShortLink) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
