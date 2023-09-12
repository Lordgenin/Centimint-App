import Foundation
import SwiftUI

extension View {
    func safeAreaInsets() -> UIEdgeInsets {
        guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return .zero
        }
        
        return scene.windows.first?.safeAreaInsets ?? .zero
    }
}
