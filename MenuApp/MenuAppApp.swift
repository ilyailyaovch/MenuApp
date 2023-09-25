import SwiftUI

@main
struct MenuAppApp: App {
    var dataStore = DataStore()
    var body: some Scene {
        WindowGroup {
            TabBarView().environmentObject(dataStore)
        }
    }
}
