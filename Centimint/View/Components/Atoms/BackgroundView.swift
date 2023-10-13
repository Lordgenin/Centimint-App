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
                            .clipShape(BulgingBottomCorners(bulgeAmount: 30))
                            .frame(minHeight: geometry.size.height * 0.4)

                        
                        Color.black
                            .cornerRadius(30, corners: [.topLeading, .topTrailing])
                            .frame(height: geometry.size.height * 0.6) // 60% of the screen height for the white part
                            }

                    .edgesIgnoringSafeArea(.all)
                }
            }
            
        }
    }
}

struct BulgingBottomCorners: Shape {
    var bulgeAmount: CGFloat = 30.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let midX = rect.midX
        
        path.move(to: CGPoint(x: 0, y: 0)) // Start top-left
        path.addLine(to: CGPoint(x: 0, y: rect.maxY - bulgeAmount)) // Move down left side
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY - bulgeAmount), control: CGPoint(x: midX, y: rect.maxY + bulgeAmount))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0)) // Move up right side to top-right
        
        return path
    }
}



struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView2()
    }
}
