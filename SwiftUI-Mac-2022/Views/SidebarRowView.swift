import SwiftUI

struct SidebarRowView: View {
  let code: String
  let title: String

  var body: some View {
    VStack(alignment: .leading) {
      Text(code)
        .font(.largeTitle)
        .foregroundColor(.primary)

      Text(title)
        .font(.title2)
        .truncationMode(.tail)
    }
    .padding(.horizontal)
    .padding(.vertical, 3)
  }
}

struct ListRowView_Previews: PreviewProvider {
  static var previews: some View {
    SidebarRowView(code: "418", title: "I'm a teapot")
  }
}
