import Foundation

struct CoinDetailResponse: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
    }

    enum ImageCodingKeys: String, CodingKey {
        case large
        case small
        case thumb
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        symbol = try container.decode(String.self, forKey: .symbol)
        name = try container.decode(String.self, forKey: .name)

        if let imageContainer = try? container.nestedContainer(keyedBy: ImageCodingKeys.self, forKey: .image) {
            image = try imageContainer.decodeIfPresent(String.self, forKey: .large)
                ?? imageContainer.decodeIfPresent(String.self, forKey: .small)
                ?? imageContainer.decodeIfPresent(String.self, forKey: .thumb)
        } else {
            image = nil
        }
    }
}
