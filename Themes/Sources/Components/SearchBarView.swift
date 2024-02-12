import Resources
import SwiftUI

public struct SearchBarView: View {
	private var onTap: () -> Void

	public init(onTap: @escaping () -> Void) {
		self.onTap = onTap
	}

	public var body: some View {
		Button(action: { onTap() }) {
			ZStack(alignment: .leading) {
				Color.white

				HStack(spacing: 8) {
					Image(.magnifyingGlass)
						.resizable()
						.renderingMode(.template)
						.foregroundStyle(.gray)
						.frame(width: 18, height: 18)

					Text("Buscar produto")
						.font(.Raleway.fixed(.semibold, size: .t1))
						.foregroundStyle(.gray)
				}
				.padding(.horizontal, 20)
			}
			.frame(height: 60)
			.clipShape(.rect(cornerRadius: 30))
		}
		.shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 10)
	}
}

#Preview {
	ZStack {
		AppColors.antiflashWhite.colorValue.ignoresSafeArea()

		SearchBarView {
			print("Tapped")
		}
		.padding(.horizontal)
	}
}
