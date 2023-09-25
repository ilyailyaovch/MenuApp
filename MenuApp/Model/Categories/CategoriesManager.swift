import Foundation
import SwiftyJSON

final class CategoriesManager: ObservableObject {
    @Published var categories: [Category] = []
    
    func fetchCategories() {
        if let url = URL(string: Urls.catigoriesUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    print("\(FileManagerErrors.errorFetchingData): \(error)")
                    return
                }
                
                guard let jsonData = data else {
                    print(FileManagerErrors.noDataReceived)
                    return
                }
                
                self?.parseCategoriesFromJSON(jsonData: jsonData)
            }.resume()
        } else {
            print(FileManagerErrors.invalidURL)
        }
    }

    func parseCategoriesFromJSON(jsonData: Data) {
        DispatchQueue.main.async { [weak self] in
            let json = try? JSON(data: jsonData)
            let categoriesArray = json?[CategoriesKeys.сategories].arrayValue

            self?.categories = categoriesArray?.map { categoryJSON in
                let id = categoryJSON[CategoriesKeys.id].intValue
                let name = categoryJSON[CategoriesKeys.name].stringValue
                let imageUrlString = categoryJSON[CategoriesKeys.imageUrl].stringValue
                let imageUrl = URL(string: imageUrlString)!

                return Category(id: id, name: name, imageUrl: imageUrl)
            } ?? []
        }
    }
}


