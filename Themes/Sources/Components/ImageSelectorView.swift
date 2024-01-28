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
