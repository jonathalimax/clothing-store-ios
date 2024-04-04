import Resources
import SwiftUI
import Tools
import Dependencies

public struct FloatTabView: View {
	@Dependency(\.tabBar) var tabBar

	private let tabs: [Item]
	@State private var selected: Int = .zero
	@State private var isVisible: Bool = true

	public init(tabs: [Item]) {
		self.tabs = tabs
	}

	public var body: some View {
		ZStack(alignment: .bottom) {
			TabView(selection: $selected) {
				ForEach(tabs, id: \.id) { item in
					AnyView(item.screen)
						.toolbar(.hidden, for: .tabBar)
				}
			}

			if isVisible {
				tabBarView
			}
		}
		.onReceive(tabBar.visibility) {
			isVisible = $0
		}
	}

	private var tabBarView: some View {
		HStack(spacing: 4) {
			ForEach(tabs, id: \.id) { item in
				Image(systemName: selected == item.id ? item.selectedIcon : item.icon)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.scaleEffect(selected == item.id ? 1.25 : 1)
					.foregroundStyle(AppColors.charlestonGreen.colorValue)
					.onTapGesture {
						withAnimation {
							selected = item.id
						}
					}
			}
			.padding(.horizontal, 22)
			.padding(.vertical, 24)
		}
		.background(.ultraThinMaterial)
		.frame(height: 68)
		.clipShape(.rect(cornerRadius: 22))
		.shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 14)
	}
}

extension FloatTabView {
	public struct Item {
		let id: Int
		let icon: String
		let selectedIcon: String
		let screen: any View

		public init(id: Int, icon: String, selectedIcon: String, screen: any View) {
			self.id = id
			self.icon = icon
			self.selectedIcon = selectedIcon
			self.screen = screen
		}
	}
}

#if DEBUG
private extension [FloatTabView.Item] {
	static let mock: Self = [
		.init(
			id: 0,
			icon: "newspaper",
			selectedIcon: "newspaper.fill",
			screen: Color.white
		),
		.init(
			id: 1,
			icon: "person",
			selectedIcon: "person.fill",
			screen: Color.red
		),
		.init(
			id: 2,
			icon: "cart",
			selectedIcon: "cart.fill",
			screen: Color.black
		),
	]
}

#Preview("Light") {
	ZStack {
		AppColors.antiflashWhite.colorValue
			.ignoresSafeArea()

		FloatTabView(tabs: .mock)
	}
}

#Preview("Dark") {
	ZStack {
		AppColors.antiflashWhite.colorValue
			.ignoresSafeArea()

		FloatTabView(tabs: .mock)
	}
	.preferredColorScheme(.dark)
}
#endif
