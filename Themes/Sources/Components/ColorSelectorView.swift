import Resources
import SwiftUI

public struct ColorSelectorView: View {
	@State private var selected: Data?
	private var items: Set<Data>
	private var onSelect: (Data) -> Void

	public init(_ items: Set<Data>, _ onSelect: @escaping (Data) -> Void) {
		self.items = items
		self.onSelect = onSelect
	}

	public var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(alignment: .center, spacing: 12) {
				ForEach(Array(items), id: \.self) { item in
					colorItem(item.color, selected: item == selected)
						.onTapGesture {
							onSelect(item)
							withAnimation { selected = item }
						}
				}
				.padding(.vertical, 8)
			}
			.frame(maxWidth: .infinity)
		}
		.scrollBounceBehavior(.basedOnSize, axes: .horizontal)
	}

	private func colorItem(_ color: Color, selected: Bool) -> some View {
		ZStack {
			if selected {
				color.overlay {
					ZStack {
						Color.black
							.opacity(0.1)
							.background(.ultraThinMaterial)

						Circle()
							.stroke(
								AppColors.charlestonGreen.colorValue.opacity(0.6),
								lineWidth: 4
							)
					}
				}
			} else {
				color
			}
		}
		.frame(width: 50, height: 50)
		.clipShape(.circle)
	}
}

extension ColorSelectorView {
	public struct Data: Hashable {
		let id: UUID
		let color: Color

		public init(id: UUID, color: Color) {
			self.id = id
			self.color = color
		}
	}
}

#if DEBUG
private extension Set<ColorSelectorView.Data> {
	static let mock: Self = [
		.init(id: .init(), color: .white),
		.init(id: .init(), color: .black),
		.init(id: .init(), color: .red),
	]
}
#Preview("Light") {
	ZStack {
		AppColors.antiflashWhite.colorValue.ignoresSafeArea()

		ColorSelectorView(.mock) { _ in }
			.frame(height: 50)
	}
}

#Preview("Dark") {
	ZStack {
		AppColors.antiflashWhite.colorValue.ignoresSafeArea()

		ColorSelectorView(.mock) { _ in }
			.frame(height: 50)
			.preferredColorScheme(.dark)
	}
}
#endif
