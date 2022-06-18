import SwiftUI

struct CatImageView: View {
  @AppStorage("showCopyright") var showCopyright: Bool = false
  @Environment(\.controlActiveState) private var controlActiveState

  private let flipImageMenuItemSelected = NotificationCenter.default
    .publisher(for: .flipImage)
    .receive(on: RunLoop.main)

  let catImage: NSImage
  let statusCode: String

  @State private var imageIsFlipped = false
  
  var body: some View {
    VStack {
      Image(nsImage: catImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .rotation3DEffect(Angle(degrees: imageIsFlipped ? 180 : 0),
                          axis: (x: 0, y: 1, z: 0))
        .animation(.default, value: imageIsFlipped)
        .overlay(
          Text(showCopyright ? "Copyright © https" + "://http.cat" : "")
            .padding(6)
            .font(.caption)
            .foregroundColor(.white)
            .shadow(radius: 5)
          ,alignment: .bottomTrailing)
    }
    .onReceive(flipImageMenuItemSelected) { _ in
      if controlActiveState == .key || controlActiveState == .active {
        imageIsFlipped.toggle()
      }
    }
  }
}

struct CatImageView_Previews: PreviewProvider {
  static var previews: some View {
    let image = NSImage(systemSymbolName: "photo.artframe", accessibilityDescription: "photo")!
    return CatImageView(catImage: image, statusCode: "000")
  }
}
