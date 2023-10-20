import SwiftUI

class InsightsViewModel: ObservableObject {
    let appCoordinator: AppCoordinator
    let serviceManager: ServiceManager
    
    init(appCoordinator: AppCoordinator, serviceManager: ServiceManager) {
        self.appCoordinator = appCoordinator
        self.serviceManager = serviceManager
    }
}

struct InsightsView: View {
    @ObservedObject var viewModel: InsightsViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Image(systemName: "arrow.left") // <- Back button, you might want to customize this
                    .font(.system(size: 24))
                    .onTapGesture {
                        viewModel.appCoordinator.showHomeScreen()
                    }
                Spacer()
                Text("Insights")
                    .font(.title)
                    .bold()
                   
                Spacer()
            }
            
            .padding()
            
            Text("Spending habits this week")
                .font(.title2)
                .bold()
                .padding(.bottom, 20)
            
            // Replace with your pie chart view
           PieChartView(data: [
            PieSliceData(title: "Eating habits", value: 10),
            PieSliceData(title: "Test2", value: 20),
            PieSliceData(title: "Test3", value: 30),
            PieSliceData(title: "Eating habits", value: 40),
            PieSliceData(title: "Test2", value: 50),
            PieSliceData(title: "Test3", value: 60),
            PieSliceData(title: "Eating habits", value: 70),
            PieSliceData(title: "Test2", value: 80),
            PieSliceData(title: "Test3", value: 90)
        ])
            
            VStack(spacing: 10) {
                GradientButtonGroupView(titles: ["Eating habits",
                                                 "Drinking habits",
                                                "Other habits",
                                                 "Other habits",
                                                 "Other habits"
                                                ], actions: [
                                                    { print("Action for Test1") },
                                                    { print("Action for Test2") },
                                                    { print("Action for Test3") },
                                                    { print("Action for Test3") },
                                                    { print("Action for Test3") }
                                                ]
                                            )

            }
            .padding(.top, 30)
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func habitButton(title: String) -> some View {
        Button(action: {
            // Handle button action here
        }) {
            Text(title)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .cornerRadius(10)
        }
    }
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView(viewModel: InsightsViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager()), serviceManager: ServiceManager()))
    }
}
