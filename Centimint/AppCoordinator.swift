//
//  AppCoordinator.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/18/23.
//

import Foundation
import SwiftUI
import RevenueCat
import AuthenticationServices
import Firebase

protocol Screen {
    func makeView(serviceManager: ServiceManager, appCoordinator: AppCoordinator) -> AnyView
}

class AppCoordinator: ObservableObject {
    enum Screen {
        case splash
        case introView
        case registration
        case appIntro
        case home
        case log
        case changePassword
        case profile
        case aboutScreen
        case terms
        case privacyPolicy
        case settings
        case calendar(viewModel: CalendarViewModel)
        case weeklyCalendar(viewModel: WeeklyCalendarViewModel)
        case alert(viewModel: NotificationPanelViewModel)
        case payWall
        case purchaseEntryViewModel
        case purchaseEntry
        case insights
    }
    enum ToastNotification {
        case toast(viewModel: ToastViewModel)
    }
    enum NotificationScreen {
        case notification(viewModel: CustomModalViewModel)
    }
    @Published var currentScreen: Screen = .splash
    @Published var modalScreen: Screen?
    @Published var notificationScreen: NotificationScreen?
    @Published var toast: ToastNotification?
    
    @ObservedObject var serviceManager: ServiceManager
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    func handleLogin() {
        // Check if user is already authenticated, if yes move to the question screen
        if serviceManager.firebaseService.isAuthenticated {
            self.handleLoginSuccess()
        } else {
            showIntroScreen()
        }
    }
    func signUpUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        serviceManager.firebaseService.signUpWithEmailAndPassword(email: email, password: password) { result in
            switch result {
            case .success(_):
                completion(.success("success"))
                self.serviceManager.showTabBar = false
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func signIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        serviceManager.firebaseService.signInWithEmailAndPassword(email: email, password: password) { result in
            switch result {
            case .success(_):
                completion(.success("success"))
                self.serviceManager.showTabBar = false
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func handleLogout() {
        // Sign out the user and move back to the login screen
        do {
            try serviceManager.firebaseService.signOut()
            serviceManager.userService.user = nil
            serviceManager.isConfigured = false
            serviceManager.showTabBar = false
        } catch { error
            print(error)
        }
        showIntroScreen()
    }
    func handleLoginSuccess() {
        handleLogout()
        let hasSeen = UserDefaults.standard.bool(forKey: "hasIntroductionModalShown")
        print("Has user seen intro modal? \(hasSeen)")
        guard let user = Auth.auth().currentUser else {
            print("Weird user issue. User is not detected")
            return
        }
        
//        Purchases.shared.logIn(user.uid) { (purchaserInfo, error, publicError) in
//            // handle any error.
//            print(error)
//        }
        
//        Task {
//            try await serviceManager.configure()
//
//            PurchaseService.sharedInstance.checkSubscriptionStatus { [weak self] (result) in
//                switch result {
//                case .success(let isSubscribed):
//                    if isSubscribed {
                        self.showRegisterModal()
//                        UserService.sharedInstance.isSubscribed = true
//                    } else {
//                        self?.showPayWall()
//                    }
//                case .failure(let error):
//                    // Handle the error here
//                    print("Error checking subscription status: \(error)")
//                }
//            }
//        }
    }
    
    // This is a setter screen to handle setting the screens and adding transitions
    func setCurrentScreen(_ newScreen: Screen) {
        withAnimation {
            currentScreen = newScreen
        }
    }
    // Show Screens
    func showSplashScreen() {
        setCurrentScreen(.splash)
    }
    /// Show screen functions
    func showIntroScreen() {
        setCurrentScreen(.introView)
    }
    func showInsightsScreen() {
        setCurrentScreen(.insights)
    }
    func showChangePassword() {
        currentScreen = .changePassword
    }
    func showProfile() {
        currentScreen = .profile
    }
    func showHomeScreen() {
        currentScreen = .home
        self.serviceManager.showTabBar = false
    }
    func showLogScreen() {
        currentScreen = .log
    }
    func showAppIntro() {
        currentScreen = .appIntro
    }
    
    func showPayWall() {
        currentScreen = .payWall
        self.serviceManager.showTabBar = false
        modalScreen = nil
    }
    
    // Modals
    func closeModals() {
        modalScreen = nil
    }
    func hideNotification() {
        notificationScreen = nil
    }
    func showToast(viewModel: ToastViewModel) {
        toast = .toast(viewModel: viewModel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.toast = nil
        }
    }
    func purchaseEntryViewModel(){
        modalScreen = .purchaseEntryViewModel
    }
    func showPayWallModal() {
        modalScreen = .payWall
    }
    func showCalendarModal(viewModel: CalendarViewModel) {
        modalScreen = .calendar(viewModel: viewModel)
    }
    func showWeeklyCalendarModal(viewModel: WeeklyCalendarViewModel) {
        modalScreen = .weeklyCalendar(viewModel: viewModel)
    }
    func showPurchaseEntryModal(){
        modalScreen = .purchaseEntry
    }
    func hideToast() {
        toast = nil
    }
    func showPrivacyScreenModal() {
        modalScreen = .privacyPolicy
    }
    
    func showAlertPanelModal(viewModel: NotificationPanelViewModel) {
        modalScreen = .alert(viewModel: viewModel)
    }
    func showRegisterModal() {
        modalScreen = .registration
    }
    
    func showSettingsModal() {
        modalScreen = .settings
    }
    func showNotificationModal(viewModel: CustomModalViewModel) {
        notificationScreen = .notification(viewModel: viewModel)
    }
    
}

extension AppCoordinator.Screen: Screen {
    func makeView(serviceManager: ServiceManager, appCoordinator: AppCoordinator) -> AnyView {
        switch self {
        case .splash:
            return AnyView(
                SplashLoader(viewModel: SplashLoaderViewModel(serviceManager: serviceManager, appCoordinator: appCoordinator))
                    .onAppear {
                        Task {
                            do {
                                try await serviceManager.configure()
                                await Task.sleep(5 * 1_000_000_000) // Wait for 5 seconds
                                await appCoordinator.handleLogin()
                            } catch {
                                print("Configuration failed: \(error)")
                            }
                        }
                    }
            )
        case .introView:
            return AnyView(
                IntroView(viewModel: IntroViewViewModel(serviceManager: serviceManager, appCoordinator: appCoordinator))
            )
        case .appIntro:
            return AnyView(
                NewUserIntroductionView(viewModel: NewUserIntroductionViewModel(appCoordinator: appCoordinator))
            )
        case .home:
            return AnyView(
                HomeView(viewModel: HomeViewModel(appCoordinator: appCoordinator, serviceManager: serviceManager))
            )
        case .insights:
            return AnyView(
                InsightsView(viewModel: InsightsViewModel(appCoordinator: appCoordinator, serviceManager: serviceManager))
            )
        case .changePassword:
            return AnyView(
                ChangePasswordView(viewModel: ChangePasswordViewModel(appCoordinator: appCoordinator, serviceManager: serviceManager))
            )
        case .profile:
            return AnyView(
                ProfileView(viewModel: ProfileViewModel(serviceManager: serviceManager, appCoordinator: appCoordinator))
            )
        case .registration:
            return AnyView(EmptyView())
        case .payWall:
            return AnyView(EmptyView())
        case .purchaseEntryViewModel:
            return AnyView(EmptyView())
        case .purchaseEntry:
            return AnyView(EmptyView())
        case .aboutScreen:
            return AnyView(EmptyView())
        case .terms:
            return AnyView(EmptyView())
        case .privacyPolicy:
            return AnyView(EmptyView())
        case .calendar(viewModel: let viewModel):
            return AnyView(EmptyView())
        case .weeklyCalendar(viewModel: let viewModel):
            return AnyView(EmptyView())
        case .settings:
            return AnyView(EmptyView())
        case .log:
            return AnyView(EmptyView())
        case .alert(viewModel: let viewModel):
            return AnyView(EmptyView())
        }
    }
}
