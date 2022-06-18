import SwiftUI

struct MenuBarView: View {
  @Binding var httpSections: [HttpSection]

  var body: some View {
    ForEach(httpSections) { section in
      Menu("\(section.headerCode) - \(section.headerText)") {
        ForEach(section.statuses) { status in
          Button("\(status.code) - \(status.title)") {
            NSWorkspace.shared.open(status.docsUrl)
          }
        }
      }
    }
  }
}

struct MenuBarView_Previews: PreviewProvider {
  static var previews: some View {
    MenuBarView(httpSections: .constant([]))
  }
}
