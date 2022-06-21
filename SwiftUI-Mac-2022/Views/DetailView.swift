import SwiftUI

struct DetailView: View {
  let sectionTitle: String?
  let httpStatus: HttpStatus?
  @Environment(\.openWindow) private var openWindow

  var body: some View {
    VStack {
      if let sectionTitle, let httpStatus {
        StatusView(sectionTitle: sectionTitle, httpStatus: httpStatus)
      } else {
        Spacer()
        Text("Select a status.")
          .font(.largeTitle)
          .navigationTitle("HTTP Status")
      }

      Spacer()
      Button("Show UI Samples") {
        openWindow(id: "ui_samples")
      }
      .padding(.bottom)
    }
  }
}

struct OptionalDetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(sectionTitle: nil, httpStatus: nil)
  }
}
