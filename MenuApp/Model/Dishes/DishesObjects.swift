import Foundation

struct Dish: Identifiable, Equatable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let description: String
    let imageUrl: URL
    let tegs: [Tag]
}

enum Tag: String, CaseIterable {
    case allMenu = "Все меню"
    case salads = "Салаты"
    case withRice = "С рисом"
    case withFish = "С рыбой"
}

enum DishesKeys {
    static let dishes = "dishes"
    static let id = "id"
    static let name = "name"
    static let price = "price"
    static let weight = "weight"
    static let description = "description"
    static let imageUrl = "image_url"
    static let tegs = "tegs"
}
