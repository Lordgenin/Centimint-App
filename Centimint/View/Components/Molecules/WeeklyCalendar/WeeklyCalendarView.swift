import SwiftUI

class WeeklyCalendarViewModel: ObservableObject {
    @Published var appCoordinator: AppCoordinator
    @Published var startDate: Date = Date().startOfWeek

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
}

struct WeeklyCalendarView: View {
    @ObservedObject var viewModel: WeeklyCalendarViewModel
    
    private var endDate: Date {
        Calendar.current.date(byAdding: .day, value: 6, to: viewModel.startDate)!
    }

    private var dateString: String {
        "\(viewModel.startDate.monthDayFormat) - \(endDate.monthDayFormat)"
    }

    var body: some View {
        VStack {
            HStack {
                CloseButtonView {
                    viewModel.appCoordinator.closeModals()
                }
                Spacer()
            }
            .padding(.top, 50)
            .padding(.leading, 20)
            
            HStack {
                Button(action: goToPreviousWeek) {
                    Image(systemName: "arrow.left")
                        .padding()
                }

                Text(dateString)
                    .padding()

                Button(action: goToNextWeek) {
                    Image(systemName: "arrow.right")
                        .padding()
                }
            }
            .padding(.bottom, 40)
            
            WeekView(startDate: viewModel.startDate, onSelectDay: { date in
                // Callback for when day is selected
                // viewModel.appCoordinator.closeModals()
            })
            
        }
        .background(.clear)
//        (LinearGradient(gradient: Gradient(colors: [Color.black, Color.purple]), startPoint: .bottom, endPoint: .top))
        .ignoresSafeArea(.all)
    }
    
    func goToPreviousWeek() {
        viewModel.startDate = Calendar.current.date(byAdding: .day, value: -7, to: viewModel.startDate)!
    }

    func goToNextWeek() {
        viewModel.startDate = Calendar.current.date(byAdding: .day, value: 7, to: viewModel.startDate)!
    }
}

struct WeekView: View {
    let startDate: Date
    let onSelectDay: (Date) -> Void
    
    var body: some View {
        HStack {
            ForEach(daysInWeek, id: \.self) { date in
                Text("\(date.dayFormat)")
                    .foregroundColor(.black)
                    .font(.title)
                    .onTapGesture {
                        onSelectDay(date)
                    }
                Spacer()
            }
        }.padding()
    }
    
    var daysInWeek: [Date] {
        return Array(0..<7).map {
            Calendar.current.date(byAdding: .day, value: $0, to: startDate)!
        }
    }
}

struct WeeklyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeeklyCalendarView(viewModel: WeeklyCalendarViewModel(appCoordinator: AppCoordinator(serviceManager: ServiceManager())))
        }
    }
}
