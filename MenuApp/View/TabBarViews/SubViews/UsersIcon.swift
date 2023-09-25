import SwiftUI

struct UsersIcon: View {
    var body: some View {
        Image(systemName: "person.crop.circle")
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.lightLabelColor)
    }
}
