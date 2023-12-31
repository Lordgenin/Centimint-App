import SwiftUI
import AVFoundation

class SplashLoaderViewModel: ObservableObject {
    var serviceManager: ServiceManager
    var appCoordinator: AppCoordinator
    
    init(serviceManager: ServiceManager, appCoordinator: AppCoordinator) {
        self.serviceManager = serviceManager
        self.appCoordinator = appCoordinator
    }
}

struct SplashLoader: View {
    @State var viewModel: SplashLoaderViewModel
    @State private var selection = 0
//    private let videoURL = Bundle.main.url(forResource: "broll3", withExtension: "mov")!
    
    var body: some View {
        ZStack {
            (LinearGradient(gradient: Gradient(colors: [Color.Primary, Color.PGred]), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                Text(Constants.SplashLoaderName)
                    .font(.system(size: 62, weight: .bold))
                    .foregroundColor(.black)
                    .padding()
                    .opacity(selection == 0 ? 0 : 1)
                    .animation(.easeInOut(duration: 1))
                    .onAppear {
                        self.selection = 1
                    }
                Spacer()
            }
        }
    }
}

struct SplashLoader_Previews: PreviewProvider {
    static var previews: some View {
        SplashLoader(viewModel: SplashLoaderViewModel(serviceManager: ServiceManager(), appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
    }
}
