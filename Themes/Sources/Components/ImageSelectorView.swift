import SwiftUI

public struct ImageSelectorView: View {
	private var images: [URL]
	private var indexDisplayMode: PageTabViewStyle.IndexDisplayMode
	@State private var imageScale: CGFloat = 1.0

	public init(
		images: [URL] = .mock,
		indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic
	) {
		self.images = images
		self.indexDisplayMode = indexDisplayMode
	}

	public var body: some View {
		TabView {
			ForEach(images, id: \.self) { imageUrl in
				AsyncImage(
					url: imageUrl,
					content: {
						$0.resizable()
							.aspectRatio(contentMode: .fill)
							.background(Color.clear)
							.ignoresSafeArea()
					},
					placeholder: {
						AnimationView(.loading)
							.frame(width: 80, height: 80)
					}
				)
			}
		}
		.tabViewStyle(.page(indexDisplayMode: indexDisplayMode))
		.indexViewStyle(.page(backgroundDisplayMode: .always))
	}
}

extension [URL] {
	public static let mock: Self = [
		.init(string: "https://i.postimg.cc/ncVbfwmj/Copy-of-CLAREAMOR-50-batcheditor-fotor.jpg")!,
		.init(string: "https://i.postimg.cc/W42zxPVD/Copy-of-CLAREAMOR-65-batcheditor-fotor.jpg")!,
		.init(string: "https://i.postimg.cc/28VKFqBy/Copy-of-CLAREAMOR-58-batcheditor-fotor.jpg")!
	]
}

#Preview("LightMode") {
	ZStack{
		ImageSelectorView(
			images: [
				.init(string: "https://lojamorenarosa.vtexassets.com/arquivos/ids/310756-1200-auto")!,
				.init(string: "https://i.ibb.co/jL7t3QG/loja-de-roupas-femininas-online-removebg-preview.png")!,
			]
		)
	}
}

#Preview("DarkMode") {
	ImageSelectorView(
		images: [
			.init(string: "https://lojamorenarosa.vtexassets.com/arquivos/ids/310756-1200-auto")!,
			.init(string: "https://i.ibb.co/jL7t3QG/loja-de-roupas-femininas-online-removebg-preview.png")!,
		]
	)
	.preferredColorScheme(.dark)
	.ignoresSafeArea()
}
