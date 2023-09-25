import Foundation
import SwiftyJSON

final class DishesManager: ObservableObject {
    @Published var dishes: [Dish] = []
    
    func fetchDishes() {
        if let url = URL(string: Urls.dishesUrl) {
                URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                    if let error = error {
                        print("\(FileManagerErrors.errorFetchingData): \(error)")
                        return
                    }
                    
                    guard let jsonData = data else {
                        print(FileManagerErrors.noDataReceived)
                        return
                    }
                    
                    self?.parseDishesFromJSON(jsonData: jsonData)
                }.resume()
            } else {
                print(FileManagerErrors.invalidURL)
            }
        }

   private func parseDishesFromJSON(jsonData: Data) {
        DispatchQueue.main.async { [weak self] in
        let json = try? JSON(data: jsonData)
        let dishesArray = json?[DishesKeys.dishes].arrayValue
        
            self?.dishes = dishesArray?.map { dishJSON in
            let id = dishJSON[DishesKeys.id].intValue
            let name = dishJSON[DishesKeys.name].stringValue
            let price = dishJSON[DishesKeys.price].intValue
            let weight = dishJSON[DishesKeys.weight].intValue
            let description = dishJSON[DishesKeys.description].stringValue
            let imageUrlString = dishJSON[DishesKeys.imageUrl].stringValue
            let imageUrl = URL(string: imageUrlString)!
            let tegsArray = dishJSON[DishesKeys.tegs].arrayValue
            let tegs = tegsArray.map { tagJSON in
                let tagName = tagJSON.stringValue
                let tag = Tag(rawValue: tagName)!
                return tag
            }
            
            return Dish(id: id, name: name, price: price, weight: weight, description: description, imageUrl: imageUrl, tegs: tegs)
        } ?? []
    }
    }
}
