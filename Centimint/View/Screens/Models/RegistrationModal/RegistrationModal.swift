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
    
    @Published var puppyName = ""
    
    @Published var imageUrl = ""
    
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
        @State var selectedImage: UIImage? = nil
        @State private var isDatePickerShown = false
        
        func nextButtonPressed() {
            guard let u = UserService.sharedInstance.user else {
                print("Something went wrong with getting the user during auth")
                return
            }
            
            var updatedUser = u
            
            if selectedPage == 0 {
                updatedUser.monthlyinPerMonth = viewModel.monthlyInPerMonth
                UserService.sharedInstance.updateUser(user: updatedUser)
            }
            
            if selectedPage == 1 {
                updatedUser.billExpenes = viewModel.billExpenes
                UserService.sharedInstance.updateUser(user: updatedUser)
            }
            
            if selectedPage == 2 {
                updatedUser.savingGoal = viewModel.savingGoal
                UserService.sharedInstance.updateUser(user: updatedUser)
            }
            
            if selectedPage <= 3 {
                    selectedPage += 1
            
            }
            
            //once everything is selected we can create a workout for the user
            if selectedPage > 3 { UserService.sharedInstance.settings.hasIntroductionModalShown = true
                viewModel.appCoordinator.closeModals()
            }
        }
        
        var titleGroup: some View {
            VStack {
                if selectedPage == 3 {
                    HStack {
                        Spacer()  // Add this Spacer to center the VStack
                        VStack(spacing: 4) {
                            Text("We have a few questions")
                                .multilineTextAlignment(.center)
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.black)
                            Text("How much do you make a Month?")
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        Spacer()  // Add this Spacer to center the VStack
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("\(selectedPage + 1)/4")
                                .foregroundColor(Color.black)
                                .font(.subheadline)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        ProgressView(value: Double(selectedPage + 1), total: 5)
                            .padding()
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(UIColor(red: 0.35, green: 0.38, blue: 1, alpha: 1)),
                                        Color(UIColor(red: 0.85, green: 0.34, blue: 1, alpha: 1))
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .mask(
                                    ProgressView(value: Double(selectedPage + 1), total: 5)
                                        .padding()
                                )
                            )
                    }
                } else {
                    HStack {
                        Spacer()  // Add this Spacer to center the VStack
                        VStack(spacing: 9) {
                            Text(viewModel.completedRegistration.isEmpty ? "Completed Registration" : viewModel.completedRegistration)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .font(.system(size: 44))
                                .bold()
                            Text("Here's some information about your dog at this stage.")
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        Spacer()  // Add this Spacer to center the VStack
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20)

                }
            }
        }

        
        var monthlyInPerMonth: some View {
            VStack(alignment: .leading) {
                Text("Monthly Income?")
                    .bold()
                    .padding(.leading, 20)
                    .foregroundColor(.black)
                
                ZStack {
                    TextFieldWithIcon(text: $viewModel.monthlyInPerMonthString, placeholder: "", icon: .custom(.oval), isSecure: false)
                }
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1))
                .padding()
                Spacer()
                
            }
        }
        
        var billExpenes: some View {
                VStack(alignment: .leading) {
                    Text("How much are your Expenses? ")
                        .bold()
                        .padding(.leading, 20)
                        .padding(.bottom, 12)
                        .foregroundColor(.black)
                    ZStack {
                        TextFieldWithIcon(text: $viewModel.billExpenesString, placeholder: "", icon: .custom(.oval), isSecure: false)
                    }
                    .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1))
                    .padding()
                    Spacer()
                        .frame(height: 60)
                }
        }

        
        var savingGoal: some View {
            VStack(alignment: .leading) {
                Text("Let's Establish a Saving Goal and Date")
                    .bold()
                    .padding(.bottom, 12)
                    .foregroundColor(.black)
                
                ZStack {
                    TextFieldWithIcon(text: $viewModel.savingGoalString, placeholder: "", icon: .custom(.oval), isSecure: false)
                }
                .background(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1))
                .padding()
                
                ZStack {
                    VStack {
                        Text("Select Date You would liek to reach Saving Goal")
                            .bold()
                            .padding(.bottom, 12)
                            .foregroundColor(.black)

                        DatePicker("Select a Date:", selection: $viewModel.goalDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }

        
        var completedRegistration: some View {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        IconImage(Icon.custom(.oval))
                            .padding(30)
                        Spacer()
                    }
                    .padding()
                    
                    Text(viewModel.completedRegistration)
                        .foregroundColor(.black)
                        .padding(.bottom)
                    
                    Text("This will be your Weekly Allowance: ")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding(.bottom)
                    
                    Spacer()
                    
//                    ForEach(Array(viewModel.completedRegistration), id: \.self) { character in
//                        VStack(alignment: .leading) {
//                            Text(String(character))
//                                .bold()
//                                .foregroundColor(.black)
//                                .padding(.bottom, 2)
//                        }
//                    }
                }
                .padding(.horizontal, 20)
        }
        
        
        var body: some View {
            VStack {
                titleGroup
                
                ZStack {
                    Color.primaryPurple
                    
                    TabView(selection: $selectedPage) {
                        monthlyInPerMonth
                            .background(Color.white)
                            .tag(0)
                        
                        billExpenes
                            .background(Color.white)
                            .tag(1)
                        
                        savingGoal
                            .background(Color.white)
                            .tag(2)
                        
                        completedRegistration
                            .background(Color.white)
                            .tag(3)
            
                    }.background(.clear)
                    
                    VStack {
            
                        ConfirmationButton(title: selectedPage == 3 ? "Complete" : "Next", type: .primaryLargeConfirmation) {
                            nextButtonPressed()
                            
                        }
                        .padding()
                    }
                    
                }
            }
            .background(Color.white, ignoresSafeAreaEdges: .all)
        }
    }
    
struct RegistrationModal_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationModal(viewModel: RegistrationModalViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
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

