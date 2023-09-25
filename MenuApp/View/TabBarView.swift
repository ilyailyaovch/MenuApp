import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    private let categoriesManager = CategoriesManager()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainTabView(categoriesManager: categoriesManager)
                .tabItem {
                    TabBarImages.main.image
                        .foregroundColor(selectedTab == 0 ? TabBarImages.main.selectedColor : TabBarImages.main.deselectedColor)
                    TabBarLabels.main.label
                }
                .tag(0)
            SearchTabView()
                .tabItem {
                    TabBarImages.search.image
                        .foregroundColor(selectedTab == 1 ? TabBarImages.search.selectedColor : TabBarImages.search.deselectedColor)
                    TabBarLabels.search.label
                }
                .tag(1)
            CartTabView()
                .tabItem {
                    TabBarImages.cart.image
                        .foregroundColor(selectedTab == 2 ? TabBarImages.cart.selectedColor : TabBarImages.cart.deselectedColor)
                    TabBarLabels.cart.label
                }
                .tag(2)
            AccountTabView()
                .tabItem {
                    TabBarImages.account.image
                        .foregroundColor(selectedTab == 3 ? TabBarImages.account.selectedColor : TabBarImages.account.deselectedColor)
                    TabBarLabels.account.label
                }
                .tag(3)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
