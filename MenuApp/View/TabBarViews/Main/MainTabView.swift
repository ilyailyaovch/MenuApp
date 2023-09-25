import SwiftUI

struct MainTabView: View {
    @ObservedObject  var categoriesManager: CategoriesManager
    @StateObject  var dishesManager = DishesManager()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(categoriesManager.categories) { category in
                            NavigationLink(destination: DishesView(dishesManager: dishesManager, category: category)) {
                                categoryImage(for: category)
                            }
                        }
                    }.padding(.top, 8)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                   TabViewHeader()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    UsersIcon()
                }
            }.background(Color.white)
        }
        .onAppear {
            categoriesManager.fetchCategories()
        }
        
    }
    var imageView: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(categoriesManager.categories) { category in
                        NavigationLink(destination: DishesView(dishesManager: DishesManager(), category: category)) {
                            categoryImage(for: category)
                        }
                    }
                }.padding(.top, 8)
            }
        }
    }
    
     func categoryImage(for category: Category) -> some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: category.imageUrl) { image in
                image
                    .resizable()
                    .frame(width: 343, height: 148)
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .frame(width: 343, height: 148)
            }
            VStack(alignment: .leading) {
                Text(category.name)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
                    .frame(width: 191, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            .padding(.top, 12)
            .padding(.leading, 16)
        }
    }
}
