//
//  Entities.swift
//  Puzzloging
//
//  Created by changgyo seo on 2023/01/15.
//
import Foundation

// MARK: - CommonRes
struct CommonRes<T: Codable>: Codable {
    let success: Bool
    let data: T
    let error: JSONNull?
}

struct CommonResWithArray<T: Codable>: Codable {
    let success: Bool
    let data: [T]
    let error: JSONNull?
}

struct LoginInfo: Codable {
    let id: String
    let name: String
}

struct Image: Codable {
    let imageID: Int
    let imagePath: String
    let color: String

    enum CodingKeys: String, CodingKey {
        case imageID
        case imagePath, color
    }
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

