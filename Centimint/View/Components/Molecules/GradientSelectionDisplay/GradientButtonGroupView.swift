import SwiftUI

class GradientButtonGroupViewModel: ObservableObject {
	let appCoordinator: AppCoordinator

	init(appCoordinator: AppCoordinator) {
		self.appCoordinator = appCoordinator
	}

}

struct GradientButtonGroupView: View {
    let titles: [String]
    let actions: [() -> Void]
    
    init(titles: [String], actions: [() -> Void]) {
        assert(titles.count == actions.count, "Titles and actions count should match")
        self.titles = titles
        self.actions = actions
    }
    
    var body: some View {
        ScrollView{
            VStack {
                
                ForEach(0..<titles.count) { index in
                    ConfirmationButton(title: titles[index], type: .primaryLargeConfirmationGradientStack, action: actions[index])
                }
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.Primary, Color.PGred]), startPoint: .top, endPoint: .bottom)
            )
            .mask(
                VStack(spacing: 10) {
                    ForEach(0..<titles.count) { _ in
                        RoundedRectangle(cornerRadius: 30)
                            .frame(height: 50)
                    }
                }
                    .padding()
            )
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
        }
    }
}


struct GradientButtonGroupView_Previews: PreviewProvider {
    static var previews: some View {
        GradientButtonGroupView(
            titles: ["Eating habits", "Test2", "Test3","Eating habits", "Test2", "Test3"],
            actions: [
                { print("Action for Test1") },
                { print("Action for Test2") },
                { print("Action for Test3") },
                { print("Action for Test1") },
                { print("Action for Test2") },
                { print("Action for Test3") }
            ]
        )
    }
}
