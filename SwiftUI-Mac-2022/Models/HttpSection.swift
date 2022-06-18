import Foundation

struct HttpSection: Identifiable, Hashable {
  let id = UUID()
  let headerCode: String
  let headerText: String
  let statuses: [HttpStatus]
}

extension HttpSection: Decodable {
  enum CodingKeys: CodingKey {
    case headerCode
    case headerText
    case statuses
  }
}
