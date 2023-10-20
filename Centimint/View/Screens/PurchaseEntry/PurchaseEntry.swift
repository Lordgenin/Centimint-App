import SwiftUI

class PurchaseEntryViewModel: ObservableObject {
	let appCoordinator: AppCoordinator
    
    @Published  var purchaseName: String = ""
    @Published  var purchaseAmount: String = ""

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
        
        
        if let user = UserService.sharedInstance.user {
            self.purchaseName = user.purchaseEntries.first?.purchaseName ?? ""
            self.purchaseAmount = "\(user.purchaseEntries.first?.purchaseAmount ?? 0)"
               
            
        }
        
    }
    
}

struct PurchaseEntryView: View {
    @ObservedObject var viewModel: PurchaseEntryViewModel
    
    var body: some View {
    
        ZStack {
            BackgroundView2()
            
            
            VStack {
                
                HStack {
                    IconImage(.sfSymbol(.close, color: .black))
                        .padding()
                        .onTapGesture {
                            print("tapped")
                            viewModel.appCoordinator.closeModals()
                        }.onTapGesture {
                            print("VStack tapped")
                        }
                    Spacer()
                    
                }
            
                
                Spacer()
                
                // Logo and title
                VStack {
                    Image(systemName: "bag.fill") // Replace with your app's logo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.white)
                    
                    Text("Budget Simpler")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
                
                Spacer()
                
                // Purchase entry form
                VStack(spacing: 20) {
                    Text("Add your purchases")
                        .bold()
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    TextFieldWithIcon(text: $viewModel.purchaseName, placeholder: "Enter purchase name", icon: .custom(.oval), isSecure: false,
                                             backgroundColor: .gray.opacity(0.2))
                        .padding(.horizontal)
                    
                    
                    TextFieldWithIcon(text: $viewModel.purchaseAmount, placeholder: "Enter Amount Here", icon: .custom(.oval), isSecure: false,
                                             backgroundColor: .gray.opacity(0.2))
                        .padding(.horizontal)
                    
                    ConfirmationButton(title: "Save", type: .primaryLargeConfirmationGradient) {
                        print("Save button tapped")
                        viewModel.appCoordinator.closeModals()
                        
                    }
                    
                }
                .padding(.horizontal, 30)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)
                
                Spacer()
                
            }
        }
        .onTapGesture {
            print("ZStack tapped")
        }
       // .edgesIgnoringSafeArea(.all)
    }
}


struct PurchaseEntry_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseEntryView(viewModel: PurchaseEntryViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}
