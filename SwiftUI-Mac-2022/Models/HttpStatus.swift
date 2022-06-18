import Foundation

struct HttpStatus: Identifiable, Hashable {
  let id = UUID()
  let code: String
  let title: String

  var imageUrl: URL {
    let address = "https://http.cat/\(code).jpg"
    return URL(string: address)!
  }

  var docsUrl: URL {
    let address = "https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/\(code)"
    return URL(string: address)!
  }
}

extension HttpStatus: Decodable {
  enum CodingKeys: CodingKey {
    case code
    case title
  }
}
