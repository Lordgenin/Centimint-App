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
    
    @StateObject private var weeklyCalendarViewModel = WeeklyCalendarViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager()))

    
    var topBar: some View {
        HStack {
            WeeklyCalendarView(viewModel: weeklyCalendarViewModel)
                .padding()
            
            Text("iconhere")
            
        }
    }
    
    var midBar: some View {
        VStack {
            
            CardBackground(color: .PGred)
            
        }
    }
    var overviewBar: some View {
        ScrollView{
            VStack {
                
                CardBackground(color: .PGred)
                CardBackground(color: .PGred)
                CardBackground(color: .PGred)
                
                
            }
            .padding()
        }
    }
    
//
//    var inProgressModule: some View {
//        VStack {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Currently Learning")
//                        .font(.subheadline)
//                        .foregroundColor(.black)
//                        .padding(.bottom, 8)
//
//
//                }
//
//            }
//            Spacer()
//        }
//        .padding(.bottom, 10)
//
//        return ConfirmationButton(title: "Continue Training", type: .primaryLargeConfirmation) {
//        }
//        .padding()
//    }
    
    var body: some View {
      
            ZStack {
                VStack {
                    topBar
                    midBar
                    overviewBar
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
