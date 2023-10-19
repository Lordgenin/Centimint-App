//
//  PurchaseEntry.swift
//  Centimint
//
//  Created by Sompumpkins on 10/18/23.
//

import SwiftUI

class PurchaseEntryModel: ObservableObject {
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

struct PurchaseEntry: View {
    @ObservedObject var viewModel: PurchaseEntryModel
    
    var body: some View {
    
        ZStack {
            BackgroundView2()
            
            
            VStack {
                // Back arrow (placeholder)
                HStack {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .padding()
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
                        
                    }
                    
                }
                .padding(.horizontal, 30)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)
                
                Spacer()
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct PurchaseEntry_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseEntry(viewModel: PurchaseEntryModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}
