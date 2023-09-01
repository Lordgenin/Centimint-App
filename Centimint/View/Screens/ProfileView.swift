import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var serviceManager: ServiceManager
    @Published var appCoordinator: AppCoordinator
    
    init(serviceManager: ServiceManager, appCoordinator: AppCoordinator) {
        self.serviceManager = serviceManager
        self.appCoordinator = appCoordinator
    }
    
}
struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        Text("Hello, World! this is the proflie view")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(serviceManager: ServiceManager(), appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}
