import Resources
import SwiftUI

public struct BannerView: View {
	public var banners: [BannerView.Data]

	public init(banners: [BannerView.Data]) {
		self.banners = banners
	}

	public var body: some View {
		GeometryReader { geo in
			ScrollView(.horizontal, showsIndicators: false) {
				LazyHStack {
					ForEach(banners, id: \.id) {
						if banners.count == 1 {
							contentView(banner: $0)
								.containerRelativeFrame(.horizontal)
						} else {
							contentView(banner: $0)
								.frame(width: geo.size.width - 32)
						}
					}
				}
			}
			.scrollTargetBehavior(.paging)
			.scrollDisabled(banners.count == 1)
			.shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 20)
		}
	}

	private func contentView(banner: BannerView.Data) -> some View {
		VStack(alignment: .leading, spacing: 2) {
			Text(banner.title)
				.font(.Raleway.fixed(.semibold, size: .h6))
				.foregroundStyle(AppColors.white.colorValue)
				.lineLimit(1)

			Text(banner.subtitle)
				.font(.Raleway.fixed(.bold, size: .h6))
				.foregroundStyle(AppColors.boogerBuster.colorValue)
				.lineLimit(1)

			if let description = banner.description {
				Text(description)
					.font(.Raleway.fixed(.medium, size: .t2))
					.lineSpacing(2)
					.foregroundStyle(AppColors.white.colorValue)
					.lineLimit(2)
					.padding(.top, 8)
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(28)
		.background(AppColors.darkBackground.colorValue)
		.clipShape(.rect(cornerRadius: 48))
		.padding(.horizontal, 12)
	}
}

extension BannerView {
	public struct Data {
		let id: Int
		let title, subtitle: String
		let description: String?

		public init(id: Int, title: String, subtitle: String, description: String?) {
			self.id = id
			self.title = title
			self.subtitle = subtitle
			self.description = description
		}
	}
}
#if DEBUG
extension [BannerView.Data] {
	static let oneBanner: Self = [
		.init(
			id: .zero,
			title: "Último desconto",
			subtitle: "Até 70%",
			description: "Compre agora e ganhe frete grátis! Compre agora e ganhe frete grátis!"
		)
	]

	static let multipleBanners: Self = [
		.init(
			id: .zero,
			title: "Último desconto",
			subtitle: "Até 70%",
			description: "Compre agora e ganhe frete grátis!"
		),
		.init(
			id: 1,
			title: "Último desconto",
			subtitle: "Até 70%",
			description: "Compre agora e ganhe frete grátis! Não Perca essa oportunidade"
		),
		.init(
			id: 2,
			title: "Último desconto",
			subtitle: "Até 70%",
			description: nil
		)
	]
}

#Preview("Light One Banner") {
	ZStack {
		AppColors.antiflashWhite.colorValue.ignoresSafeArea()

		BannerView(banners: .oneBanner)
	}
}

#Preview("Light Multiple Banners") {
	ZStack {
		AppColors.antiflashWhite.colorValue.ignoresSafeArea()

		BannerView(banners: .multipleBanners)
	}
}

#Preview("Dark One Banner") {
	ZStack {
		AppColors.darkBackground.colorValue.ignoresSafeArea()

		BannerView(banners: .oneBanner)
	}
	.preferredColorScheme(.dark)
}

#Preview("Dark Multiple Banners") {
	ZStack {
		AppColors.darkBackground.colorValue.ignoresSafeArea()

		BannerView(banners: .multipleBanners)
	}
	.preferredColorScheme(.dark)
}
#endif
