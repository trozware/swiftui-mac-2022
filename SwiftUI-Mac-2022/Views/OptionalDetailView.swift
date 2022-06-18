//
//  DetailView.swift
//  SwiftUI-Mac-13
//
//  Created by Sarah Reichelt on 15/6/2022.
//

import SwiftUI

struct DetailView: View {
  let sectionTitle: String?
  let httpStatus: HttpStatus?
  
  var body: some View {
    if let sectionTitle, let httpStatus {
      StatusView(sectionTitle: sectionTitle, httpStatus: httpStatus)
    } else {
      Text("Select a status")
        .font(.largeTitle)
        .navigationTitle("HTTP Status")
    }
  }
}

struct OptionalDetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(sectionTitle: nil, httpStatus: nil)
  }
}
