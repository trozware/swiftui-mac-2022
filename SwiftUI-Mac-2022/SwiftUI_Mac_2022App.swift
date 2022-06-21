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

    // OPENING SECONDARY WINDOWS

    // Use this method if you want to allow the window to open multiple times
    //        WindowGroup("Samples", id: "ui_samples") {
    //          SamplesView()
    //        }

    // This method will open one window for each different String passed
    //    WindowGroup(for: String.self) { _ in
    //      SamplesView()
    //    }

    // This will only ever open a single window
    // and it will add a menu item to the Windows menu
    Window("Samples", id: "ui_samples") {
      SamplesView()
    }
    .keyboardShortcut("u")
    // The default modifiers don't appear to work
    .defaultPosition(.topLeading)


    MenuBarExtra("HTTP Status Code", systemImage: "network", isInserted: $showMenuBar) {
      MenuBarView(httpSections: $httpSections)
    }
  }
}
