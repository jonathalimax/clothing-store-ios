import Resources
import SwiftUI
import Main

@main
struct ClothingStoreApp: App {
	var body: some Scene {
        WindowGroup {
			MainView(store: .init(initialState: .init()) {
				MainReducer()
			})
			.tint(AppColors.charlestonGreen.colorValue)
        }
    }
}
