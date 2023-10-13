import SwiftUI

struct BackgroundView2: View {
    var invertColors: Bool = false
    
    var body: some View {
        ZStack {
            if invertColors {
                
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        Color.white
                            .frame(height: geometry.size.height * 0.7) // 40% of the screen height for the white part
                        
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                            .cornerRadius(30) // Adding corner radius to the gradient
                            .frame(minHeight: geometry.size.height * 0.3) // At least 60% of the screen height for the gradient
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            
            else {
                
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                            .frame(minHeight: geometry.size.height * 0.4) // At least 60% of the screen height for the gradient
                        
                        Color.white
                            .cornerRadius(50, corners: .top)
                            .frame(height: geometry.size.height * 0.6) // 60% of the screen height for the white part
                            }

                    .edgesIgnoringSafeArea(.all)
                }
                .background(Color.purple)
            }
            
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView2()
    }
}
