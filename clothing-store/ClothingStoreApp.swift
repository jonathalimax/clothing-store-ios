import Resources
import SwiftUI
import Main

@main
struct ClothingStoreApp: App {
//	@Environment(\.scenePhase) private var phase

    var body: some Scene {
        WindowGroup {
			MainView(store: .init(initialState: .init()) {
				MainReducer()
			})
			.tint(AppColors.charlestonGreen.colorValue)
        }
//		.onChange(of: phase) { _, newPhase in
//			switch newPhase {
//			case .active:
//				print("active")
//			case .background:
//				print("background")
//			case .inactive:
//				print("inactive")
//			@unknown default:
//				break
//			}
//		}
    }
}
