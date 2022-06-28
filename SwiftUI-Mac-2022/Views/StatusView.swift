import SwiftUI

struct StatusView: View {
  let sectionTitle: String
  let httpStatus: HttpStatus

  @State private var catImage: NSImage?

  var body: some View {
    VStack {
      Text("HTTP Status Code: \(httpStatus.code)")
        .font(.headline)
        .padding()
      Text(httpStatus.title)
        .font(.title)

      AsyncImage(url: httpStatus.imageUrl) { img in
        CatImageView(catImage: img, statusCode: httpStatus.code)
      } placeholder: {
        Spacer()
        ProgressView()
        Spacer()
      }
      .id(httpStatus)   // this resets the AsyncImage whenever httpStatus changes

      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationTitle("\(sectionTitle) - \(httpStatus.title)")
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    StatusView(sectionTitle: "4xx",
               httpStatus: HttpStatus(code: "404", title: "Not Found"))
  }
}
