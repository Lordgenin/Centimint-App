import SwiftUI

struct TextFieldWithIcon: View {
    @Binding var text: String
    let placeholder: String
    let icon: Icon
    let isSecure: Bool
    let backgroundColor: Color
    let foregroundColor: Color
    @State private var showSecureText: Bool = false
    
    init(text: Binding<String>, placeholder: String, icon: Icon, isSecure: Bool, backgroundColor: Color = Color.gray.opacity(0.2), foregroundColor: Color = .black) {
        self._text = text
        self.placeholder = placeholder
        self.icon = icon
        self.isSecure = isSecure
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .frame(height: 56)
            
            HStack {
                Spacer()
                IconImage(icon)
                    .frame(width: 22, height: 22)
                    .padding(.trailing, 5)
                
                CustomTextField(text: $text, placeholder: placeholder, placeholderColor: foregroundColor, foregroundColor: foregroundColor, isSecure: isSecure, showSecureText: showSecureText)
                
                if isSecure {
                    Button(action: {
                        showSecureText.toggle()
                    }) {
                        Image(systemName: showSecureText ? "eye.slash" : "eye")
                            .foregroundColor(foregroundColor)
                    }
                    Spacer()
                }
            }
        }
        .cornerRadius(10)
    }
}


struct TextFieldWithIcon_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithIcon(text: .constant(""), placeholder: "Email address", icon: .sfSymbol(.message, color: .black), isSecure: false)
    }
}
