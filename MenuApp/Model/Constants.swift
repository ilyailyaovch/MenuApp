import Foundation

enum Urls{
    static let dishesUrl = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
    static let catigoriesUrl = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
}

enum FileManagerErrors: Error {
    case errorFetchingData
    case noDataReceived
    case invalidURL
}
