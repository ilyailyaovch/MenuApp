import Foundation

final class DataStore: ObservableObject {
    @Published var dishesInCart: [Dish] = []
    @Published var purchaseAmount: Int = 0
    
    func addItem(_ dish: Dish) {
        dishesInCart.append(dish)
    }
    
    func deleteItem(_ dish: Dish) {
        if let index = dishesInCart.firstIndex(of: dish) {
            dishesInCart.remove(at: index)
        }
    }
}

