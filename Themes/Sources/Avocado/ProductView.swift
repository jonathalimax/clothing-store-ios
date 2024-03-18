import SwiftUI
import Resources
import Components

public struct ProductView: View {
	private var data: ProductView.Data

	public init(data: ProductView.Data) {
		self.data = data
	}

	public var body: some View {
		ZStack {
//			AppColors.lotion.colorValue

			VStack(spacing: .zero) {
				ImageSelectorView(images: data.images)

				VStack(alignment: .leading, spacing: 6) {
					Group {
						Text(data.name)
							.font(.Raleway.fixed(.semibold, size: .t2))
							.foregroundStyle(AppColors.charlestonGreen.colorValue)


						Text(data.price)
							.font(.Raleway.fixed(.bold, size: .t2))
							.foregroundStyle(AppColors.charlestonGreen.colorValue)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
				}
				.padding()
				.background(AppColors.lotion.colorValue)
			}
			.background(.ultraThinMaterial)
		}
		.clipShape(.rect(cornerRadius: 18))
		.shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 10)
	}
}

extension ProductView {
	public struct Data {
		let name: String
		let price: String
		let images: [URL]

		public init(name: String, price: String, images: [URL]) {
			self.name = name
			self.price = price
			self.images = images
		}
	}
}

#if DEBUG
private extension ProductView.Data {
	static let mock: Self = .init(
		name: "Kimono Granada",
		price: "R$ 9,99",
		images: [
			.init(string: "https://i.postimg.cc/ncVbfwmj/Copy-of-CLAREAMOR-50-batcheditor-fotor.jpg")!,
			.init(string: "https://i.postimg.cc/W42zxPVD/Copy-of-CLAREAMOR-65-batcheditor-fotor.jpg")!
		]
	)
}

#Preview("LightMode") {
	ZStack {
		AppColors.antiflashWhite.colorValue
			.ignoresSafeArea()

		HStack {
			ProductView(data: .mock)
				.frame(height: 290)

			ProductView(data: .mock)
				.frame(height: 290)
		}
		.padding()
	}
}

#Preview("DarkMode") {
	ZStack {
		AppColors.antiflashWhite.colorValue
			.ignoresSafeArea()

		HStack {
			ProductView(data: .mock)
				.frame(height: 290)

			ProductView(data: .mock)
				.frame(height: 290)
		}
		.padding()
	}
	.preferredColorScheme(.dark)
}
#endif
