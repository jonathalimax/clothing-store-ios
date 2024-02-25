import Lottie
import Resources
import SwiftUI

public struct AnimationView: View {
	private var animation: LocalAnimation

	public init(_ animation: LocalAnimation) {
		self.animation = animation
	}

	public var body: some View {
		LottieView.init(animation: .named(animation.rawValue, bundle: animation.bundle))
			.playing()
			.looping()
	}
}
