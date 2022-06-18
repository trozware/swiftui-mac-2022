import SwiftUI
import Charts

struct ChartSamplesView: View {
  @State private var chartData: [String: Int] = [:]
  @State private var drawHorizontal = false

  var body: some View {
    let chartView = Group {
      Text("Status codes by category")
        .font(.title3).bold()
        .padding()

      HStack {
        Text(drawHorizontal ? "Category" : "Count").bold()
          .rotationEffect(.degrees(270))

        Chart {
          ForEach(chartData.keys.sorted(), id: \.self) { key in
            barMark(for: key)
              .foregroundStyle(by: .value( "Color", key))
          }

          ruleMark()
            .foregroundStyle(.gray)
        }
        .chartForegroundStyleScale([
          "1xx": .green,
          "2xx": .purple,
          "3xx": .blue,
          "4xx": .yellow,
          "5xx": .red
        ])
        .chartLegend(.hidden)
        .padding(.trailing)
      }

      Text(drawHorizontal ? "Count" : "Category").bold()
    }

    VStack {
      chartView

      HStack {
        Picker("Orientation:", selection: $drawHorizontal) {
          Text("Vertical").tag(false)
          Text("Horizontal").tag(true)
        }
        .pickerStyle(.segmented)
        .padding()

        Button("Save Chart as Image") {
          let view = chartView
            .padding()
            .frame(width: 1200, height: 800)

          let renderer = ImageRenderer(content: view)
          if let exportImage = renderer.nsImage {
            saveImage(exportImage)
          }
        }
      }
      .padding(.horizontal)

    }
    .animation(.easeInOut, value: drawHorizontal)
    .onAppear(perform: readCodes)
  }

  func barMark(for key: String) -> BarMark {
    if drawHorizontal {
      return BarMark(
        x: .value("Count", chartData[key] ?? 0),
        y: .value("Category", key)
      )
    } else {
      return BarMark(
        x: .value("Category", key),
        y: .value("Count", chartData[key] ?? 0)
      )
    }
  }

  func ruleMark() -> RuleMark {
    if drawHorizontal {
      return RuleMark(
        x: .value("Threshold", 8)
      )
    } else {
      return RuleMark(
        y: .value("Threshold", 8)
      )
    }
  }

  func readCodes() {
    let httpSections = Bundle.main.decode([HttpSection].self, from: "httpcodes.json")

    for section in httpSections {
      chartData[section.headerCode] = section.statuses.count
    }
  }

  func saveImage(_ image: NSImage) {
    let saveURL = showSavePanel()
    if let saveURL {
      let imageRepresentation = NSBitmapImageRep(data: image.tiffRepresentation!)
      let jpgData = imageRepresentation?.representation(using: .jpeg, properties: [:])
      try? jpgData?.write(to: saveURL)
    }
  }

  func showSavePanel() -> URL? {
    let savePanel = NSSavePanel()

    savePanel.allowedContentTypes = [.jpeg]
    savePanel.canCreateDirectories = true
    savePanel.isExtensionHidden = false

    savePanel.title = "Save your image"
    savePanel.message = "Choose a folder and a name to store the image."
    savePanel.nameFieldLabel = "Image file name:"
    savePanel.nameFieldStringValue = "Chart.jpg"

    let response = savePanel.runModal()
    return response == .OK ? savePanel.url : nil
  }
}

struct ChartSamplesView_Previews: PreviewProvider {
  static var previews: some View {
    ChartSamplesView()
  }
}
