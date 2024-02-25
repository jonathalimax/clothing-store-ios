import SwiftUI
import Resources
import Components

public struct ProductView: View {
	public init() {}

	public var body: some View {
		ZStack {
			AppColors.lotion.colorValue

			VStack {
				ImageSelectorView(
					images: [
						.init(string: "https://i.pinimg.com/originals/88/1f/61/881f615abd6b80ee5c33f13ad22eadbd.png")!,
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
				.padding(.horizontal)
				.padding(.bottom, 6)
			}
			.padding(.vertical)
		}
		.clipShape(.rect(cornerRadius: 28))
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
