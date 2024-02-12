import Components
import Resources
import SwiftUI

struct ProductDetailView: View {
	var body: some View {
		ZStack {
			AppColors.antiflashWhite.colorValue
				.ignoresSafeArea()

			ImageSelectorView(
				images: [
					.init(string: "https://eu.billebeino.com/cdn/shop/products/BB-WHD27-CROSUNDANCECROPHOODIE.jpg?v=1693912450")!,
					.init(string: "https://eu.billebeino.com/cdn/shop/products/BB-WHD27-CROSUNDANCECROPHOODIE.jpg?v=1693912450")!,
				]
			)
		}
	}
}

#Preview {
	ProductDetailView()
}
