import SwiftUI

struct DishesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedTag: Tag = .allMenu
    @ObservedObject  var dishesManager: DishesManager
    
    var category: Category
    @State private var selectedDish: Dish? = nil
    @State private var showDetails: Bool = false
    
    private var filteredDishes: [Dish] {
        if selectedTag == .allMenu {
            return dishesManager.dishes
        } else {
            return dishesManager.dishes.filter { $0.tegs.contains(selectedTag) }
        }
    }
    
    var body: some View {
        ZStack {
        VStack (spacing: 16) {
            CategorySelected(selectedTag: $selectedTag)
            
            ZStack {
                ScrollView (.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [ GridItem(), GridItem(), GridItem() ]) {
                        ForEach(filteredDishes) { dish in
                            LazyHStack (alignment: .top){
                                Button {
                                    withAnimation(.linear(duration: 0.3)) {
                                        selectedDish = dish
                                        showDetails = true
                                    }
                                } label: {
                                    dishIcon(for: dish)
                                }
                                
                            }
                        }
                    } .padding(.top, 8)
                } .padding(.horizontal, 16)
                
            }
        }
            DishesDetailView(show: $showDetails, dish: selectedDish)
    }
        .navigationBarTitle(category.name, displayMode: .automatic)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationBarItems(trailing: UsersIcon())
        .background(Color.white)
        .accentColor(.black)
        .onAppear {
            dishesManager.fetchDishes()
        }
        
    }
    
    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image("chevron")
                .resizable()
                .frame(width: 6, height: 12)
                .padding(.leading, 8)
        }
    }
    
    private func dishIcon(for dish: Dish) -> some View {
        VStack (spacing: 5) {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.container)
                    .frame(width: 110, height: 110)
                
                AsyncImage(url: dish.imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 85, height: 85)
                } placeholder: {
                    ProgressView()
                        .frame(width: 85, height: 85)
                }
            }
            Text(dish.name)
                .foregroundColor(.black)
                .font(.system(size: 14))
                .frame(width: 109, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
    }
}
