import Resources
import SwiftUI

public enum ClothingSize: CaseIterable {
	case small, medium, large, extraLarge

	var symbol: String {
		switch self {
		case .small: "P"
		case .medium: "M"
		case .large: "G"
		case .extraLarge: "XG"
		}
	}
}

public struct SizeSelectorView: View {
	@State private var selected: ClothingSize?
	private var items = ClothingSize.allCases
	private var onSelect: ((ClothingSize) -> Void)?

	public init(_ onSelect: ((ClothingSize) -> Void)?) {
		self.onSelect = onSelect
	}

	public var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(alignment: .center, spacing: 12) {
				ForEach(items, id: \.self) { item in
					sizeItem(item, selected: item == selected)
						.onTapGesture {
							onSelect?(item)
							withAnimation { selected = item }
						}
				}
				.padding(.vertical, 8)
			}
			.frame(maxWidth: .infinity)
		}
		.scrollBounceBehavior(.basedOnSize, axes: .horizontal)
	}

	private func sizeItem(_ size: ClothingSize, selected: Bool) -> some View {
		ZStack {
			if selected {
				AppColors.darkBackground.colorValue
			} else {
				AppColors.white.colorValue
			}

			Text(size.symbol)
				.font(.Raleway.fixed(.bold, size: .h6))
				.foregroundStyle(
					selected ? AppColors.white.colorValue : AppColors.darkBackground.colorValue
				)
		}
		.frame(width: 50, height: 50)
		.clipShape(.circle)
	}
}

#Preview("Light") {
	ZStack {
		AppColors.antiflashWhite.colorValue.ignoresSafeArea()

		SizeSelectorView { _ in }
			.frame(height: 50)
	}
}

#Preview("Dark") {
	ZStack {
		AppColors.antiflashWhite.colorValue.ignoresSafeArea()

		SizeSelectorView { _ in }
			.frame(height: 50)
			.preferredColorScheme(.dark)
	}
}
