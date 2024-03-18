import SwiftUI
import Resources
import Components

public struct ProductView: View {
	public init() {}

	public var body: some View {
		ZStack {
			AppColors.lotion.colorValue

			VStack(spacing: .zero) {
				ImageSelectorView(
					images: [
						.init(string: "https://lojamorenarosa.vtexassets.com/arquivos/ids/310756-1200-auto")!,
						.init(string: "https://i.ibb.co/jL7t3QG/loja-de-roupas-femininas-online-removebg-preview.png")!,
					]
				)

				VStack(alignment: .leading, spacing: 6) {
					Group {
						Text("Crop Hoodie")
							.font(.Raleway.fixed(.semibold, size: .t2))
							.foregroundStyle(AppColors.charlestonGreen.colorValue)


						Text("R$ 9,99")
							.font(.Raleway.fixed(.bold, size: .t2))
							.foregroundStyle(AppColors.charlestonGreen.colorValue)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
				}
				.padding()
				.background(AppColors.lotion.colorValue)
			}
		}
		.clipShape(.rect(cornerRadius: 18))
		.shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 10)
	}
}

#Preview("LightMode") {
	ZStack {
		AppColors.antiflashWhite.colorValue
			.ignoresSafeArea()

		HStack {
			ProductView()
				.frame(height: 290)

			ProductView()
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
			ProductView()
				.frame(height: 290)

			ProductView()
				.frame(height: 290)
		}
		.padding()
	}
	.preferredColorScheme(.dark)
}
