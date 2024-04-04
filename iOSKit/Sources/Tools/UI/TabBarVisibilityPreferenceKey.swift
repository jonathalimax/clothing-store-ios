import Combine
import Dependencies

public struct TabBar {
	public let visibility = CurrentValueSubject<Bool, Never>(false)
}

extension TabBar: DependencyKey {
	public static var liveValue: TabBar = .init()
	public static var testValue: TabBar = .init()
}

extension DependencyValues {
	public var tabBar: TabBar {
		get { self[TabBar.self] }
		set { self[TabBar.self] = newValue }
	}
}
