import Foundation

extension NumberFormatter {
	public static var currency: NumberFormatter {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale(identifier: "pt_BR")
		return formatter
	}

	public func string(_ decimal: Decimal) -> String {
		NumberFormatter.currency.string(from: decimal as NSNumber) ?? "\(decimal)"
	}
}
