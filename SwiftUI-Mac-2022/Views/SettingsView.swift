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
    Form {
      Toggle(isOn: $showCopyright) {
        Text("Show Copyright Notice")
      }
      Toggle(isOn: $showMenuBar) {
        Text("Show Menu Bar App")
      }
    }
    .toggleStyle(.switch)
    .formStyle(.grouped)
    .frame(width: 300, height: 130)
    .navigationTitle("Settings")
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
