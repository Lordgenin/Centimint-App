import SwiftUI

enum ButtonType {
    case primaryLargeConfirmation
    case primaryLargeConfirmationGradient
    case primaryLargeConfirmationGradientText
    case primaryLargeConfirmationWithShadow
    case primaryLargeConfirmationGradientStack
    case animatedCircleButton(icon: Icon)
    case backButton
    case loading
    case plusButton
}

struct ConfirmationButton: View {
    var title: String
    var type: ButtonType
    @State var isLoading: Bool = false

    var action: () -> ()
    
    @State private var isExpanded: Bool = false

    var body: some View {
        switch type {
        case .primaryLargeConfirmation:
            Button(action: action) {
                Text(title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.background)
                    .cornerRadius(18)
            }
            
        case .primaryLargeConfirmationGradient:
            Button(action: action) {
                Text(title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.Primary, Color.PGred]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea(.all)
                    )
                    .cornerRadius(18)
            }
            
        case .primaryLargeConfirmationGradientStack:
            Button(action: action) {
                Text(title)
                          .font(.title3)
                          .bold()
                          .foregroundColor(.white)
                          .padding()
                          .frame(maxWidth: .infinity)
                          .background(Color.clear)
                          .contentShape(Rectangle())
                          .onTapGesture(perform: action)
            }
            
        case .primaryLargeConfirmationGradientText:
            Button(action: action) {
                ZStack {
                    // Gray background
                    Color.white
                        .cornerRadius(18)

                    // Gradient text
                    Text(title)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.Primary, Color.PGred]), startPoint: .top, endPoint: .bottom)
                                .mask(Text(title).bold().font(.title3))
                        )
                }
                .padding(.horizontal)
                .frame(height: 50) // Define the height or adjust accordingly
                .cornerRadius(18)
            }
            
        case .primaryLargeConfirmationWithShadow:
                    Button(action: action) {
                        ZStack {
                            HStack {
                                        Text(title)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text("30")
                                            .font(.headline)
                                            .foregroundColor(Color.gray)
                                    }
                                .padding()
                                //.frame(maxWidth: .infinity)
                                .background(.white)
                                .cornerRadius(18)
                               
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        }
                        .frame(height: 50)
                    }

        case .plusButton:
            Button(action: action) {
                
                
                    Image(systemName: "plus") // Using SF Symbols here
                        .font(.system(size: 40))
                        .frame(width: 56, height: 56)
                        .foregroundColor(.white)
                        .background(  LinearGradient(gradient: Gradient(colors: [Color.Primary, Color.PGred]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(28)
                
            }
                        
      


        case .animatedCircleButton(let icon):
            Button(action: {
                            if isExpanded {
                                // if button is already expanded, execute the action immediately
                                action()
                            } else {
                                // if button is not expanded, animate the expansion and wait for next tap
                                withAnimation(.spring()) {
                                    isExpanded = true
                                }
                                // set a timer to collapse the button if it's not tapped within 30 seconds
                                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                                    withAnimation(.spring()) {
                                        isExpanded = false
                                    }
                                }
                            }
            }) {
                ZStack {
                    if !isExpanded {
                        IconImage(icon)
                            .frame(width: 56, height: 56)
                            .background(Color.black)
                            .cornerRadius(28)
                            .opacity(isExpanded ? 0 : 1)
                    }
                    
                    if isExpanded {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(Color.black)
                            .padding(.horizontal, 60)
                            .padding(.vertical, 20)
                            .background(Color.secondaryWhite)
                            .cornerRadius(50)
                            .frame(minWidth: 56, maxWidth: .infinity)
                            .opacity(isExpanded ? 1 : 0)
                            .transition(.scale)
                            .onAppear {
                                // when the expanded button appears, cancel the previous timer and set a new one
                                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                                    withAnimation(.spring()) {
                                        isExpanded = false
                                    }
                                }
                            }
                            .onDisappear {
                                // when the expanded button disappears (i.e., the action is executed), reset the timer
                                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                                    withAnimation(.spring()) {
                                        isExpanded = false
                                    }
                                }
                            }
                    }
                }
            }
                                
        case .backButton:
            Button(action: action) {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.clear)
                        .frame(width: 46, height: 46)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.secondaryWhite, lineWidth: 1)
                        )
                    IconImage(.custom(.miniChevLeft))
                        .frame(width: 24, height: 24)
                }
                .frame(width: 46, height: 46)
            }
        case .loading:
            ZStack {
                Circle()
                    .fill(Color.secondaryWhite)
                
                if isLoading {
                    // When loading, show the spinning loading icon
                    LottieView(animationName: "loading", loopMode: .loop)
                        .frame(width: 30, height: 30)
                        .padding()
                } else {
                    // When loading is finished, show the check icon
                    IconImage(.sfSymbol(.check, color: .green))
                        .scaledToFit()
                        .padding()
                        .frame(width: 40, height: 40)
                        .animation(.default)
                }
            }
            .frame(width: 60, height: 60)
            .onAppear {
                // Animate the button to a spinning loading state
                withAnimation(.default) {
                    self.isLoading = true
                }
                
                // When loading is complete, change the icon to a check and animate to green
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.default) {
                        self.isLoading = false
                    }
                    
                    // Add another delay of 1 second before animating back to the original state
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.default) {
                            self.isLoading = false
                        }
                    }
                }
            }
            .onDisappear {
                self.isLoading = false
            }

        }
    }
}

struct ConfirmationButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ConfirmationButton(title: "test", type: .primaryLargeConfirmation) {
                print("aciton")
            }
            ConfirmationButton(title: "test", type: .primaryLargeConfirmation) {
                print("aciton")
            }
            ConfirmationButton(title: "test", type: .primaryLargeConfirmationWithShadow) {
                print("aciton")
            }
            ConfirmationButton(title: "test", type: .primaryLargeConfirmationGradientText) {
                print("action 2")
            }
            ConfirmationButton(title: "test", type: .animatedCircleButton(icon: .sfSymbol(.plus, color: .black))) {
                print("action 2")
            }
            ConfirmationButton(title: "test", type: .plusButton) {
                print("action 2")
            }
            
    
                VStack {
                            // Gradient
                            LinearGradient(gradient: Gradient(colors: [Color.Primary, Color.PGred]), startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea(.all)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                    
            ConfirmationButton(title: "test", type: .primaryLargeConfirmationGradientStack) {
                print("action 2")
            }
            ConfirmationButton(title: "test", type: .primaryLargeConfirmationGradientStack) {
                print("action 2")
            }
            ConfirmationButton(title: "test", type: .primaryLargeConfirmationGradientStack) {
                print("action 2")
            }
        }
                .padding()
            
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.Primary, Color.PGred]), startPoint: .top, endPoint: .bottom)
                        )
                        .mask(
                            VStack(spacing: 10) {
                                Rectangle().frame(height: 50)
                                Rectangle().frame(height: 50)
                                Rectangle().frame(height: 50)
                            }
                            .padding()
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .padding()
            
            ConfirmationButton(title: "test", type: .primaryLargeConfirmationGradient) {
                print("action 2")
            }
            .padding()
            ConfirmationButton(title: "test", type: .primaryLargeConfirmationGradient) {
                print("action 2")
            }
            .padding()
            
            VStack {
                Text("How was the workout?")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.secondaryWhite)
                
//                ConfirmationButton(title: "test", type: .animatedCircleButton(icon: .sfSymbol(.upload, color: .blue)), foregroundColor: .color(.blue)) {
//                    print("action 2")
                }
                Spacer()
            }
        
            .background(Color.secondaryCharcoal)
        }
    }
//}
