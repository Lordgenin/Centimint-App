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
    
    @State private var isPurchaseEntryPresented: Bool = false
    
    var topBar: some View {
        HStack {
            Image(systemName: "arrow.left") // <- Use SF symbols for this
            Text("Sep 1 - Sep 15")
                .bold()
            Spacer()
            Text("iconhere") // Replace with actual settings icon
            Image(systemName: "arrow.right") // <- Use SF symbols for this
        }
        .padding()
    }
    
    var midBar: some View {
        VStack(alignment: .leading) {
            Text("$4000 - $800")
                .bold()
                .padding(.bottom, 5)
            
            ProgressBar(progress: 0.22, color: Color.blue) // Update color and progress as needed
                .frame(height: 20)
        }
        .padding()
        .background( LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).opacity(0.5))
        .cornerRadius(10)
    }

    
    var overviewBar: some View {
        VStack(spacing: 20) {

           
                ForEach(0..<5) { _ in
                    // Here, I'm using the ConfirmationButton as an example.
                    // You may want to customize or create a new type to represent each purchase card.
                    ConfirmationButton(title: "Item", type: .primaryLargeConfirmationWithShadow) {
                        print("Item tapped")
                    }
                }
            }
           .padding()
       }

    var addButton: some View {
        ConfirmationButton(title: "test", type: .plusButton) {
            isPurchaseEntryPresented.toggle()
        }
                .padding(.vertical, 10)
    }
    
    var bottomBar: some View {
        HStack {
            ConfirmationButton(title: "Allowance", type: .primaryLargeConfirmationGradientText) {
            }
           
            
           ConfirmationButton(title: "Insights", type: .primaryLargeConfirmationGradient) {

            }
        }
    }
        
    var body: some View {
       
            VStack(spacing: 20) {
                topBar
                midBar
                
                Text("Purchased this week")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.black)
                
                ScrollView {
                    overviewBar
                }
                addButton
                bottomBar
            }
            .sheet(isPresented: $isPurchaseEntryPresented) {
                PurchaseEntry(viewModel: PurchaseEntryModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
            }
            .padding()
        
                    
                    ForEach(viewModel.titles, id: \.self) { title in
                        HStack {
                            Text(title)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical)
                            Spacer()
                        }
                        .padding(.leading)
                    }
        
        .onAppear {
            let userService = UserService.sharedInstance
            delay(0) {
                if userService.settings.hasIntroductionModalShown {
                    viewModel.appCoordinator.showRegisterModal()
                }
            }
        }
    }
    
}


    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView(viewModel: HomeViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager()), serviceManager: ServiceManager()))
        }
    }

