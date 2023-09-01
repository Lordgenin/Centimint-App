import Foundation
import SwiftUI

class NewUserIntroductionViewModel: ObservableObject {
    @Published var appCoordinator: AppCoordinator
    
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

struct NewUserIntroductionView: View {
    @State private var continuePressed: Bool = false
    @ObservedObject var viewModel: NewUserIntroductionViewModel
    
    var body: some View {
        ZStack {
            
// MARK: - Question
//            Color.white
//                .edgesIgnoringSafeArea(.all)
// why have back ground like this?
//
            
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text("Getting to know you.")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.gray)
                        .padding()
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()
                }
                
                (Text("In the ") + Text("Identity phase").bold().foregroundColor(.blue) + Text(", we help you understand yourself better through a series of questions."))
                    .foregroundColor(.black)
                    .padding()
                    .multilineTextAlignment(.leading)

                (Text("Your answers create a ") + Text("personalized experience").foregroundColor(.blue).bold() + Text(", helping the AI learn your interests, goals, and preferences."))
                    .foregroundColor(.black)
                    .padding()
                    .multilineTextAlignment(.leading)

                (Text("Our goal: help you achieve ") + Text("personal growth").bold().foregroundColor(.blue) + Text(", make informed decisions, and discover tailored opportunities."))
                    .foregroundColor(.black)
                    .padding()
                    .multilineTextAlignment(.leading)

                (Text("As the AI learns more about you, it provides ") + Text("accurate and relevant recommendations").bold().foregroundColor(.blue) + Text(", guiding your self-discovery and improvement journey."))
                    .foregroundColor(.black)
                    .padding()
                    .multilineTextAlignment(.leading)
                
                Spacer()
                ConfirmationButton(title: "Continue", type: ButtonType.primaryLargeConfirmation) {
                    //Show what ever we need to show for quicklifts
                }
                
                .padding(.horizontal, 26)
                .padding(.bottom, 20)
            }
            // MARK: - Background Color
            .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.purple]), startPoint: .bottom, endPoint: .top))
        }
    }
}

struct NewUserIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserIntroductionView(viewModel: NewUserIntroductionViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}
