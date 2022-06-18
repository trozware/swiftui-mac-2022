import SwiftUI

struct SamplesView: View {
  @State private var selectedTab = 0

  var body: some View {
    VStack {
      TabView(selection: $selectedTab) {
        ChartSamplesView().tabItem { Text("Chart") }.tag(1)
        FormSamplesView().tabItem { Text("Form") }.tag(2)
      }

      Spacer()
    }
    .padding()
    .frame(minWidth: 600, minHeight: 550)
  }
}

struct Samplesview_Previews: PreviewProvider {
  static var previews: some View {
    SamplesView()
  }
}

struct ExplanatoryText: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.subheadline)
      .foregroundColor(.secondary)
  }
}
