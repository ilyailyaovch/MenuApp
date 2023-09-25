import SwiftUI

struct  CategorySelected: View {
    @Binding var selectedTag: Tag
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(Tag.allCases, id: \.self) { tag in
                    Text(tag.rawValue)
                        .foregroundColor(selectedTag == tag ? .white : .black)
                        .font(.system(size: 14))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(selectedTag == tag ? Color.assistant: Color.container)
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedTag = tag
                        }
                }
            } .padding()
        }
        .padding(.top, 16)
        .frame(maxHeight: 50)
    }
    
}
