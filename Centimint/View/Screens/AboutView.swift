import Foundation
import SwiftUI

class AboutViewModel: ObservableObject {
    @Published var appCoordinator: AppCoordinator
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

struct AboutView: View {
    @State private var continuePressed: Bool = false
    @ObservedObject var viewModel: AboutViewModel
    var body: some View {
        VStack {
            HStack {
                CloseButtonView {
                    viewModel.appCoordinator.closeModals()
                }
                .padding(.leading, 20)
                .padding(.top, 50)
                Spacer()
            }
            ScrollView {
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack {
                            Text("Welcome to QuickLifts.")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.secondaryWhite)
                                .padding()
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                        (Text("Your friendly AI-powered ") + Text("fitness partner!").bold().foregroundColor(.black))
                            .foregroundColor(.black)
                            .padding()
                            .multilineTextAlignment(.leading)
                        Text("QuickLifts")
                            .foregroundColor(.black)
                            .padding()
                            .multilineTextAlignment(.leading)

                        Text("QuickLifts")
                            .foregroundColor(.black)
                            .padding()
                            .multilineTextAlignment(.leading)
                        Text("Test")
                            .foregroundColor(.black)
                            .padding()
                            .multilineTextAlignment(.leading)
                        Text("Test")
                            .foregroundColor(.black)
                            .padding()
                            .multilineTextAlignment(.leading)
                        Text("Test")
                            .foregroundColor(.black)
                            .padding()
                            .multilineTextAlignment(.leading)
                        Text("Test")
                            .foregroundColor(.black)
                            .padding()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
        .background(Color.gray)
    }
}
