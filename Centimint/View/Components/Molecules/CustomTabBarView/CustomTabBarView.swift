import SwiftUI

enum Tab {
    case home, log, list, profile
}

class CustomTabBarViewModel: ObservableObject {
    let appCoordinator: AppCoordinator
        
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

struct CustomTabBarView: View {
    @ObservedObject var viewModel: CustomTabBarViewModel
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack {
            HStack {
                TabButton(
                    icon: IconImage(.custom(selectedTab == .home ? .oval : .oval)),
                        text: "Training",
                        isSelected: selectedTab == .home,
                        action: {
                            selectedTab = .home
                            viewModel.appCoordinator.showHomeScreen()
                        },
                        color: .black
                )
                .padding(.horizontal)
                
                Spacer()
                
                TabButton(
                    icon: IconImage(.custom(selectedTab == .log ? .oval : .oval)),
                        text: "Log",
                        isSelected: selectedTab == .log,
                        action: {
                            selectedTab = .log
                            viewModel.appCoordinator.showLogScreen()
                        },
                        color: .black
                )
                .padding(.horizontal)
                
                Spacer()
                
                TabButton(
                    icon: IconImage(.custom(selectedTab == .list ? .oval : .oval)),
                        text: "List",
                        isSelected: selectedTab == .list,
                        action: {
                            selectedTab = .list
                            viewModel.appCoordinator.showSplashScreen()
                        },
                        color: .black
                )
                .padding(.horizontal)
                
                Spacer()
                
                TabButton(
                    icon: IconImage(.custom(selectedTab == .profile ? .oval : .oval)),
                        text: "Profile",
                        isSelected: selectedTab == .profile,
                        action: {
                            selectedTab = .profile
                            viewModel.appCoordinator.showProfile()
                        },
                        color: .black
                )
                .padding(.horizontal)
                
            }
            .padding()
            .background(Color.red)
            .cornerRadius(20, corners: .top)
        }
    }
}

private struct TabButton: View {
    var icon: IconImage
    var text: String
    var isSelected: Bool
    var action: () -> Void
    var color: Color

    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            VStack {
                icon
                .frame(width: 24, height: 24)
                Text(isSelected ? text : text)
                    .bold()
                    .font(.subheadline)
//                    .frame(width: isSelected ? 60 : 0)
            }
            .foregroundColor(isSelected ? color : .black)
            .padding(.horizontal, isSelected ? 20 : 0)
            .padding(.vertical, isSelected ? 10 : 0)
        }
    }
}


struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView(viewModel: CustomTabBarViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}
