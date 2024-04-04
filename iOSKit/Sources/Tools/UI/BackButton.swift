import Resources
import SwiftUI

struct CSBackButton: ViewModifier {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

	func body(content: Content) -> some View {
		content
			.navigationBarBackButtonHidden(true)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Image(systemName: "chevron.left")
						.font(.system(.body, weight: .bold))
						.foregroundStyle(AppColors.charlestonGreen.colorValue)
						.frame(width: 42, height: 42)
						.background(.ultraThinMaterial)
						.clipShape(.rect(cornerRadius: 16))
						.onTapGesture {
							presentationMode.wrappedValue.dismiss()
						}
				}
			}
	}
}

public extension View {
	func simpleBackButton() -> some View {
		modifier(CSBackButton())
	}
}
