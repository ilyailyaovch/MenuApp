import SwiftUI

struct DishesDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var dataStore: DataStore
    @Binding var show: Bool
    
    var dish: Dish?
    
    var body: some View {
        ZStack {
            Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
            if show {
                VStack (spacing: 8) {
                    imageView
                    infPanel
                    addButton
                }
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.white))
            }
        }
        
    }
    var imageView: some View {
        ZStack(alignment: .center) {
            if let dish = dish {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.container)
                    .frame(width: 311, height: 232)
                
                AsyncImage(url: dish.imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 198, height: 204)
                } placeholder: {
                    ProgressView()
                        .frame(width: 198, height: 204)
                }
                controlPanel
            }
        }.frame(width: 311, height: 232)
    }
    var controlPanel: some View {
        VStack {
            HStack(spacing: 8) {
                Spacer()
                createPanelsButton(imageName: "like")
                createPanelsButton(imageName: "dismiss")
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.3)) {
                            show = false
                        }
                    }
            }
            Spacer()
        }.padding(10)
    }
    private func createPanelsButton(imageName: String) -> some View  {
        Image(imageName)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
            )
    }
    var infPanel: some View {
        VStack (spacing: 8) {
            if let dish = dish {
                Text(dish.name)
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(1)
                    .frame(width: 311, alignment: .leading)
                
                HStack (spacing: 0) {
                    Text("\(dish.price) ₽")
                        .foregroundColor(.black)
                    Text(" · \(dish.weight)г")
                        .foregroundColor(.black.opacity(0.4))
                    Spacer()
                }
                .font(.system(size: 14))
                .frame(width: 311, alignment: .leading)
                Text(dish.description)
                    .foregroundColor(.subLabelColor)
                    .font(.system(size: 14))
                    .frame(width: 311, alignment: .leading)
            }
        }
    }
    var addButton: some View {
        Button {
            if let dish = dish {
                dataStore.addItem(dish)
                dataStore.purchaseAmount += dish.price
            }
            withAnimation(.linear(duration: 0.3)) {
                show = false
            }
        } label: {
            Text("Добавить в корзину")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.assistant)
                        .frame(width: 311, height: 48)
                    
                )
        }
        .frame(width: 311, height: 48)
        .padding(.top, 8)
    }
}
