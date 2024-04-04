import Resources
import SwiftUI

public struct SearchBarView: View {
	private var onTap: () -> Void

	public init(onTap: @escaping () -> Void) {
		self.onTap = onTap
	}

	public var body: some View {
		ZStack(alignment: .leading) {
			Color.clear

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
		.frame(height: 52)
		.background(.ultraThickMaterial)
		.clipShape(.rect(cornerRadius: 20))
		.shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 10)
		.onTapGesture { onTap() }
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
