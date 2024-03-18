import Resources
import SwiftUI

public struct BannerView: View {
	public var imageURL: String

	public init(imageURL: String) {
		self.imageURL = imageURL
	}

	public var body: some View {
		TabView {
			contentView

			contentView
		}
		.shadow(color: Color.black.opacity(0.5), radius: 26, x: 0, y: 20)
		.tabViewStyle(.page(indexDisplayMode: .always))
		.frame(height: 220)
	}

	private var contentView: some View {
		ZStack {
			AppColors.darkBackground.colorValue

			HStack(alignment: .top, spacing: 8) {
				VStack(alignment: .leading, spacing: 6) {
					Text("Último desconto")
						.font(.Raleway.fixed(.semibold, size: .h4))
						.foregroundStyle(AppColors.white.colorValue)

					Text("até 70%")
						.font(.Raleway.fixed(.bold, size: .h5))
						.foregroundStyle(AppColors.boogerBuster.colorValue)

					Text("Compre agora e ganhe frete grátis!")
						.font(.Raleway.fixed(.medium, size: .t2))
						.foregroundStyle(AppColors.white.colorValue)
				}
				.padding(.top, 4)

				Spacer()

				AsyncImage(
					url: URL(string: imageURL),
					content: {
						$0.resizable()
							.scaledToFit()
					},
					placeholder: {
						ProgressView()
							.tint(AppColors.boogerBuster.colorValue)
					}
				)
				.frame(width: 100)
				.frame(maxHeight: .infinity)
			}
			.padding(.leading, 40)
			.padding(.top, 40)
		}
		.clipShape(.rect(cornerRadius: 60))
		.padding(.horizontal)
	}
}

#Preview("Light") {
	ZStack {
		AppColors.antiflashWhite.colorValue.ignoresSafeArea()

		BannerView(imageURL: "https://i.ibb.co/bXxtkfy/Subject-2.png")
	}
}

#Preview("Dark") {
	ZStack {
		AppColors.darkBackground.colorValue.ignoresSafeArea()

		BannerView(imageURL: "https://i.ibb.co/bXxtkfy/Subject-2.png")
	}
	.preferredColorScheme(.dark)
}
