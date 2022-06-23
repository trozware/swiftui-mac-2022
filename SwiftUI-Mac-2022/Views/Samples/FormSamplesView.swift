import SwiftUI

struct FormSamplesView: View {
  @State private var email = ""
  @State private var password = ""
  @State private var selectedDate = Date()
  @State private var pickChoice = 1
  @State private var checkOne = false
  @State private var checkTwo = false
  @State private var selectedColor = Color.blue

  @FocusState private var emailFieldHasFocus: Bool

  var body: some View {
    VStack {
      GroupBox {
        Form {
          TextField("Enter your email address:", text: $email)
            .focused($emailFieldHasFocus)

          SecureField("Enter your password:", text: $password)

          DatePicker("Enter your birthday:", selection: $selectedDate, displayedComponents: [.date])
            .padding(.bottom)

          Form {
            Toggle("Check 1:", isOn: $checkOne)

            Toggle("Check 2:", isOn: $checkTwo)

            Picker("Select One:", selection: $pickChoice) {
              Text("Option 1").tag(1)
              Text("Option 2").tag(2)
              Text("Option 3").tag(3)
            }
          }
          .toggleStyle(.switch)
          .formStyle(.grouped)

          HStack {
            ColorPicker(selection: $selectedColor, supportsOpacity: true) {
              Text("Choose a color:")
            }
            .frame(height: 50)

            Spacer(minLength: 50)

            Capsule()
              .fill(selectedColor.gradient)
              .frame(maxWidth: .infinity)
              .frame(height: 50)
              .shadow(radius: 5)
          }
          .padding(.top)
        }
        .formStyle(.columns)
        .textFieldStyle(.roundedBorder)
        .padding()
      }

      Spacer()
    }
    .padding()
    .frame(width: 500, height: 420)
    .onAppear {
      emailFieldHasFocus = true
    }
  }
}

struct FormSamplesView_Previews: PreviewProvider {
  static var previews: some View {
    FormSamplesView()
  }
}
