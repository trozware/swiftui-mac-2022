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

      if let catImage {
        CatImageView(catImage: catImage, statusCode: httpStatus.code)
      } else {
        Spacer()
        ProgressView()
      }

      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationTitle("\(sectionTitle) - \(httpStatus.title)")
    .task(id: httpStatus) {
      catImage = nil
      await getCatImage(status: httpStatus)
    }
  }

  func getCatImage(status: HttpStatus) async {
    let request = URLRequest(url: status.imageUrl)

    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
        return
      }
      catImage = NSImage(data: data)
    } catch {
      print(error)
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    StatusView(sectionTitle: "4xx",
               httpStatus: HttpStatus(code: "404", title: "Not Found"))
  }
}
