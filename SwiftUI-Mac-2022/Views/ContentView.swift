import SwiftUI

struct ContentView: View {
  let httpSections: [HttpSection]
  
  @State private var selectedStatus: HttpStatus?
  @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
  
  var body: some View {
    NavigationSplitView(columnVisibility: $columnVisibility) {
      List(httpSections, selection: $selectedStatus) { section in
        Section(header: Text("\(section.headerCode) - \(section.headerText)")) {
          ForEach(section.statuses) { status in
            SidebarRowView(code: status.code, title: status.title)
              .tag(status)
          }
        }
        .font(.headline)
      }
      .frame(minWidth: 250)
    } detail: {
      DetailView(sectionTitle: sectionHeader, httpStatus: selectedStatus)
    }
    
    .frame(minWidth: 650, idealWidth: 800, maxWidth: .infinity,
           minHeight: 300, idealHeight: 400, maxHeight: .infinity)
  }
  
  var sectionHeader: String? {
    if let selectedStatus {
      let selectedSection = httpSections.first { section in
        section.statuses.contains(selectedStatus)
      }
      return selectedSection?.headerText
    }
    return nil
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(httpSections: Bundle.main.decode([HttpSection].self, from: "httpcodes.json")
    )
  }
}
