import SwiftUI

public struct ImageSelectorView: View {
	private var images: [URL]

	public init(images: [URL]) {
		self.images = images
	}

	public var body: some View {
		TabView {
			ForEach(images, id: \.self) { imageUrl in
				AsyncImage(
					url: imageUrl,
					content: {
						$0.resizable()
							.aspectRatio(contentMode: .fit)
							.background(Color.clear)
					},
					placeholder: { ProgressView() }
				)
				.padding(.bottom)
			}
		}
		.tabViewStyle(.page)
		.indexViewStyle(.page(backgroundDisplayMode: .always))
	}
}

#Preview {
	ImageSelectorView(
		images: [
			.init(string: "https://i.pinimg.com/originals/88/1f/61/881f615abd6b80ee5c33f13ad22eadbd.png")!,
			.init(string: "https://i.ibb.co/jL7t3QG/loja-de-roupas-femininas-online-removebg-preview.png")!,
		]
	)
}
