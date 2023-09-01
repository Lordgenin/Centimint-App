import SwiftUI

class HomeViewModel: ObservableObject {
    let appCoordinator: AppCoordinator
    let serviceManager: ServiceManager
    
    @Published var showLoader = false
    @Published var titles: [String] = []
    
    init(appCoordinator: AppCoordinator, serviceManager: ServiceManager) {
        self.appCoordinator = appCoordinator
        self.serviceManager = serviceManager
    }
}

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    
    
    var topBar: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text("Good Day!")
                    .foregroundColor(.secondaryWhite)
                    .font(.headline)
                    .bold()
                Text("test")
                    .foregroundColor(.secondaryWhite)
                    .font(.subheadline)
            }
            .padding(.leading, 10)
            
            Spacer()
            
                .padding(.trailing, 20)
        }
    }
    
    
    var inProgressModule: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Currently Learning")
                        .font(.subheadline)
                        .foregroundColor(.secondaryWhite)
                        .padding(.bottom, 8)
                    
                    
                }
                
            }
            Spacer()
        }
        .padding(.bottom, 10)
        
        return ConfirmationButton(title: "Continue Training", type: .primaryLargeConfirmation) {
        }
        .padding()
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                //            if let _ = CommandService.sharedInstance.previousCommand {
                //                VStack {
                //                    HStack {
                //                        Spacer()
                //                        IconImage(.custom(.backgroundImage1))
                //                            .frame(width: 250)
                //                            .padding(.top, 200)
                //                            .offset(x: 50)
                //                    }
                //                    Spacer()
                //                }
                //            }
                VStack {
                    topBar
                    //                DropDownFilterView(viewModel: DropDownFilterViewModel(filterBy: .category))
                    
                    inProgressModule
                        .padding(.vertical, 30)
                        .padding(.horizontal, 20)
                }
            }
            
            ForEach(viewModel.titles, id: \.self) { title in
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical)
                    Spacer()
                }
                
            }
            .padding(.leading)
            Spacer()
                .frame(height: 100)
                .background(.clear)
        }
        .onAppear {
            let userService = UserService.sharedInstance
            delay(0) {
                if !userService.settings.hasIntroductionModalShown {
                    viewModel.appCoordinator.showRegisterModal()
                }
            }
        }
    }
    
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView(viewModel: HomeViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager()), serviceManager: ServiceManager()))
        }
    }
}
