import SwiftUI

class RegistrationModalViewModel: ObservableObject {
    @Published var appCoordinator: AppCoordinator
    
    @Published var birthday: String = ""
    @Published var birthdate: Date = Date()
    
    @Published var monthlyInPerMonth: Double = 0.0
    @Published var monthlyInPerMonthString: String = "" {
        didSet {
            updateDoubleValue(from: monthlyInPerMonthString, to: &monthlyInPerMonth)
        }
    }
    @Published var billExpenes: Double = 0.0
    @Published var billExpenesString: String = "" {
        didSet {
            updateDoubleValue(from: billExpenesString, to: &billExpenes)
        }
    }
    @Published var savingGoal: Double = 0.0
    @Published var savingGoalString: String = "" {
        didSet {
            updateDoubleValue(from: savingGoalString, to: &savingGoal)
        }
    }
    @Published var goalDate: Date = Date()
    
    @Published var completedRegistration = ""
    
    
    private func updateDoubleValue(from stringValue: String, to doubleValue: inout Double) {
        if let newDoubleValue = Double(stringValue) {
            doubleValue = newDoubleValue
        }
    }
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
        
        
        if let user = UserService.sharedInstance.user {
            self.monthlyInPerMonth = user.monthlyinPerMonth
            self.billExpenes = user.billExpenes
            self.savingGoal = user.savingGoal
            self.goalDate = user.goalDate
            
            
        }
        
    }
}
struct RegistrationModal: View {
    @ObservedObject var viewModel: RegistrationModalViewModel
    @State private var selectedPage = 0
  //  @State private var isDatePickerShown = false
    
    init(viewModel: RegistrationModalViewModel, initialPage: Int = 0) {
        self.viewModel = viewModel
        _selectedPage = State(initialValue: initialPage)
    }
    
    
    func nextButtonPressed() {
        guard let u = UserService.sharedInstance.user else {
            print("Something went wrong with getting the user during auth")
            return
        }
        
        var updatedUser = u
        
        if selectedPage == 0 {
            
        }
        
        if selectedPage == 1 {
            updatedUser.monthlyinPerMonth = viewModel.monthlyInPerMonth
            UserService.sharedInstance.updateUser(user: updatedUser)
        }
        
        if selectedPage == 2 {
            updatedUser.billExpenes = viewModel.billExpenes
            UserService.sharedInstance.updateUser(user: updatedUser)
        }
        
        if selectedPage == 3 {
            updatedUser.savingGoal = viewModel.savingGoal
            UserService.sharedInstance.updateUser(user: updatedUser)
        }
        
        if selectedPage <= 4 {
            selectedPage += 1
            
        }
        
        //once everything is selected we can create a workout for the user
        if selectedPage > 4 { UserService.sharedInstance.settings.hasIntroductionModalShown = true
            viewModel.appCoordinator.closeModals()
        }
    }
    
    
    var titleGroup: some View {
        VStack {
            (LinearGradient(gradient: Gradient(colors: [Color.Primary, Color.PGred]), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea(.all)
           // Color.PGred.ignoresSafeArea(.all)
            //                if (selectedPage <= 5) {
            //                    VStack(alignment: .leading, spacing: 0) {
            //                        HStack {
            //                            Text("\(selectedPage + 1)/5")
            //                                .foregroundColor(Color.black)
            //                                .font(.subheadline)
            //                                .padding(.leading, 20)
            //                            Spacer()
            //                        }
            //                        ProgressView(value: Double(selectedPage + 1), total: 5)
            //                            .padding()
            //                            .overlay(
            //                                LinearGradient(
            //                                    gradient: Gradient(colors: [
            //                                        Color(UIColor(red: 0.35, green: 0.38, blue: 1, alpha: 1)),
            //                                        Color(UIColor(red: 0.85, green: 0.34, blue: 1, alpha: 1))
            //                                    ]),
            //                                    startPoint: .leading,
            //                                    endPoint: .trailing
            //                                )
            //                                .mask(
            //                                    ProgressView(value: Double(selectedPage + 1), total: 5)
            //                                        .padding()
            //                                )
            //                            )
            //                    }
            //                }
            //                else if (selectedPage == 5) {
            //                    HStack {
            //                        Spacer()  // Add this Spacer to center the VStack
            //                        VStack(spacing: 9) {
            //                            Text(viewModel.completedRegistration.isEmpty ? "Completed Registration" : viewModel.completedRegistration)
            //                                .multilineTextAlignment(.center)
            //                                .foregroundColor(.black)
            //                                .font(.system(size: 44))
            //                                .bold()
            //                            Text("Here's some information about your dog at this stage.")
            //                                .multilineTextAlignment(.center)
            //                                .font(.headline)
            //                                .foregroundColor(.black)
            //                        }
            //                        Spacer()  // Add this Spacer to center the VStack
            //                    }
            //                    .padding(.top, 20)
            //                    .padding(.bottom, 20)
            //
            //                }
        }
    }
    
    
    var getStartedPage: some View {
        GeometryReader { geometry in
            ZStack {
                // The BackgroundView component
                BackgroundView2(invertColors: true)
                
                // Your original content
                VStack(spacing: 20) {
                    // App Logo
                    Image(systemName: "a.circle") // Replace with your logo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    
                    // App Name
                    Text(Constants.Appname)
                        .font(.largeTitle)
                        .bold()
                    
                    // Illustration
                    Image("Illustration") // Replace "Illustration" with the name of your image in the asset catalog
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.7)
                    
                    Spacer(minLength: 20) // Adjust spacing as needed
                    
                    VStack(spacing: 20) {
                        // App Description
                        VStack(spacing: 10) {
                            Text(Constants.Appname)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                            
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare.")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                        
                        // Get Started Button
                        ConfirmationButton(title: "Get Started", type: .primaryLargeConfirmationGradientText, action: nextButtonPressed)
                    
                    }
                }
                .padding()
            }
        }
    }




 
        
    var monthlyInPerMonth: some View {
        GeometryReader { geometry in
            BackgroundView2()

            VStack {
                Spacer(minLength: 0) // Push everything to the bottom
                
                VStack {
                    Image("budgetIcon") // Assuming you have an image named "budgetIcon" in your assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(.top, 20) // Adjust padding as needed
                    
                    Text(Constants.Appname)
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
                Spacer()
                VStack(spacing: 70) { // For adding space between each element inside
                    Text("How much do you make a month?")
                        .bold()
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    TextFieldWithIcon(text: $viewModel.monthlyInPerMonthString, placeholder: "Enter Amount Here", icon: .custom(.oval), isSecure: false,
                                      backgroundColor: .gray.opacity(0.2))
                    .padding(.horizontal, 40)

                    ConfirmationButton(title: "Next", type: .primaryLargeConfirmationGradient)  {
                        nextButtonPressed()
                    }
                    .padding(.horizontal, 40)
                }
            }
        }
    }


        
        var billExpenes: some View {
            GeometryReader { geometry in
                BackgroundView2()
                // ... Your other content can go here, layered on top of the background
                VStack {
                    Spacer(minLength: 0) // Push everything to the bottom
                    
                    VStack {
                        Image("budgetIcon") // Assuming you have an image named "budgetIcon" in your assets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding(.top, 20) // Adjust padding as needed
                        
                        Text(Constants.Appname)
                            .bold()
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                    }
                    Spacer()
                    VStack(spacing: 70) { // For adding space between each element inside
                        
                        Text("How much do you pay in Bills per month?")
                            .bold()
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                        
           
                        
                        TextFieldWithIcon(text: $viewModel.billExpenesString, placeholder: "Enter Amount Here", icon: .custom(.oval), isSecure: false,
                                          backgroundColor: .gray.opacity(0.2))
                        .padding(.horizontal)
                        
                        ConfirmationButton(title: "Next", type: .primaryLargeConfirmationGradient)  {

                            nextButtonPressed()
                            
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: geometry.size.height / 2)
                }
                
            }
        }
        
        var savingGoal: some View {
            GeometryReader { geometry in
                BackgroundView2()
                // ... Your other content can go here, layered on top of the background
                VStack {
                    Spacer(minLength: 0) // Push everything to the bottom
                    
                    VStack {
                        Image("budgetIcon") // Assuming you have an image named "budgetIcon" in your assets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding(.top, 20) // Adjust padding as needed
                        
                        Text(Constants.Appname)
                            .bold()
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                    }
                    Spacer()
                    VStack(spacing: 40) {
                        
                        Text("What is your Saving goal?")
                            .bold()
                            .font(.title2)
                            .multilineTextAlignment(.center)
                        

                        TextFieldWithIcon(text: $viewModel.savingGoalString, placeholder: "Enter Amount Here", icon: .custom(.oval), isSecure: false,
                                          backgroundColor: .gray.opacity(0.2))
                        .padding(.horizontal)
                        
                        DatePicker("Select a Date:", selection: $viewModel.goalDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .padding(.horizontal, 60)
                        
                        ConfirmationButton(title: "Next", type: .primaryLargeConfirmationGradient)  {

                            nextButtonPressed()
                            
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: geometry.size.height / 2)
                }
                
            }
        }
    var completedRegistration: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.Primary, Color.PGred]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 16) {
                Spacer()
                
                Image(systemName: "wallet.pass") // placeholder for the budget icon
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                
                Text("Budget Simpler")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("$$$")
                    .font(.system(size: 60))
                    .bold()
                    .foregroundColor(.white)
                
                Text("is your weekly allowance.")
                    .foregroundColor(.white)
                
                Text("If you follow this you will reach your goal by \(viewModel.goalDate)")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                ConfirmationButton(title: "Continue", type: .primaryLargeConfirmationGradientText)  {
                    nextButtonPressed()
                }
                .padding()
            }
            .padding(.top, 50) // provides padding at the top for better alignment
        }
    }

        
        
        var body: some View {
            VStack {
                //                titleGroup
                
                ZStack {
                    //Color.red
                    
                    TabView(selection: $selectedPage) {
                        getStartedPage
                            .background(Color.white)
                            .tag(0)
                        
                        monthlyInPerMonth
                            .background(Color.white)
                            .tag(1)
                        
                        billExpenes
                            .background(Color.white)
                            .tag(2)
                        
                        savingGoal
                            .background(Color.white)
                            .tag(3)
                        
                        completedRegistration
                            .background(Color.white)
                            .tag(4)
                        
                    }.background(.clear)
                    
                }
            }
            .background(Color.white, ignoresSafeAreaEdges: .all)
        }
    }
    
    struct RegistrationModal_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                
                // Preview for the first page (Monthly Income)
                RegistrationModal(viewModel: RegistrationModalViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())), initialPage: 0)
                    .previewDisplayName("Get Started")
                
                // Preview for the first page (Monthly Income)
                RegistrationModal(viewModel: RegistrationModalViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())), initialPage: 1)
                    .previewDisplayName("Monthly Income Page")
                
                // Preview for the second page (Bill Expenses)
                RegistrationModal(viewModel: RegistrationModalViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())), initialPage: 2)
                    .previewDisplayName("Bill Expenses Page")
                
                // Preview for the third page (Saving Goal)
                RegistrationModal(viewModel: RegistrationModalViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())), initialPage: 3)
                    .previewDisplayName("Saving Goal Page")
                
                // Preview for the fourth page (Completed)
                RegistrationModal(viewModel: RegistrationModalViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())), initialPage: 4)
                    .previewDisplayName("Completed")
            }
        }
    }
    
    
    
    
    struct WhiteDatePicker: UIViewRepresentable {
        @Binding var date: Date
        var onDone: () -> Void
        
        func makeUIView(context: Context) -> UIDatePicker {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.setValue(UIColor.white, forKey: "textColor")
            return datePicker
        }
        
        func updateUIView(_ uiView: UIDatePicker, context: Context) {
            uiView.date = date
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject {
            var parent: WhiteDatePicker
            
            init(_ parent: WhiteDatePicker) {
                self.parent = parent
            }
            
            @objc func done() {
                parent.onDone()
            }
        }
    }
    
//    func BackgroundView(geometry: GeometryProxy) -> some View {
//        ZStack {
//            Color.PGred
//                .ignoresSafeArea(.all)
//            
//            VStack {
//                Spacer()
//                    .frame(height: geometry.size.height / 2)
//                
//                RoundedRectangle(cornerRadius: 50, style: .circular)
//                    .foregroundColor(.white)
//            }
//            .ignoresSafeArea(.all)
//        }
//    }
