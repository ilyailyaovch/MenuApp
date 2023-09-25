import Foundation

struct Category: Identifiable {
    let id: Int
    let name: String
    let imageUrl: URL
}

enum CategoriesKeys {
      static let сategories = "сategories"
      static let id = "id"
      static let name = "name"
      static let imageUrl = "image_url"
  }
