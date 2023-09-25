import SwiftUI

enum TabBarImages: String, CaseIterable {
    case main = "main"
    case search = "search"
    case cart = "cart"
    case account = "account"
    
    var image: Image {
        return Image(self.rawValue)
            .renderingMode(.template)
    }
    
    var selectedColor: Color {
        return .accentColor
    }
    
    var deselectedColor: Color {
        return .gray
    }
}

enum TabBarLabels: String, CaseIterable {
    case main = "Главная"
    case search = "Поиск"
    case cart = "Корзина"
    case account = "Аккаунт"
    
    var label: some View {
        Text(rawValue)
    }
}
