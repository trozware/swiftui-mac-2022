//
//  SettingsView.swift
//  SwiftUI-Mac-13
//
//  Created by Sarah Reichelt on 15/6/2022.
//

import SwiftUI

struct SettingsView: View {
  @AppStorage("showCopyright") var showCopyright: Bool = false
  @AppStorage("showMenuBar") var showMenuBar = true

  var body: some View {
    VStack(alignment: .leading) {
      Toggle(isOn: $showCopyright) {
        Text("Show Copyright Notice")
      }
      Toggle(isOn: $showMenuBar) {
        Text("Show Menu Bar App")
      }
    }
    .frame(width: 220, height: 100)
    .navigationTitle("Settings")
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
