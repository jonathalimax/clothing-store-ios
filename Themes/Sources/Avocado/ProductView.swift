import SwiftUI
import Resources
import Components

public struct ProductView: View {
	public init() {}

	public var body: some View {
		ZStack {
			Color.white

			VStack {
				ImageSelectorView(
					images: [
						URL(string: "https://eu.billebeino.com/cdn/shop/products/BB-WHD27-CROSUNDANCECROPHOODIE.jpg?v=1693912450")!,
						URL(string: "https://www.smartexapparel.com/hires/4150PLPINK_032822135651.png")!,
					]
				)

				VStack(alignment: .leading, spacing: 6) {
					HStack {
						Group {
							Text("Crop Hoodie")

							Spacer()

							Text("$9.99")
						}
						.font(.system(size: 14, weight: .bold))
					}

					Text("Zara")
						.font(.system(size: 14, weight: .regular))
				}
			}
			.padding()
		}
		.clipShape(.rect(cornerRadius: 20))
		.shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 10)
	}
}

#Preview() {
	ZStack {
		AppColors.antiflashWhite.colorValue
			.ignoresSafeArea()

		HStack {
			ProductView()
				.frame(width: 200, height: 260)

			ProductView()
				.frame(width: 200, height: 260)
		}
	}
}
