import SwiftUI

@main
struct SwiftUI_Mac_2022App: App {
  @AppStorage("showMenuBar") var showMenuBar = true

  @State private var httpSections: [HttpSection] = []

  var body: some Scene {
    WindowGroup {
      ContentView(httpSections: httpSections)
        .onAppear {
          httpSections = Bundle.main.decode([HttpSection].self, from: "httpcodes.json")
        }
    }.commands {
      Menus()
    }

    Settings {
      SettingsView()
    }


    // Use this method if you want to allow the window to open multiple times
    //    WindowGroup(id: "ui_samples") {
    //      SamplesView()
    //    }

    // This method will open one window for each different String passed
    WindowGroup(for: String.self) { _ in
      SamplesView()
    }


    MenuBarExtra("HTTP Status Code", isInserted: $showMenuBar) {
      MenuBarView(httpSections: $httpSections)
    }
  }
}
