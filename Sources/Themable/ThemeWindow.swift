//
//  ThemeWindow.swift
//  Themable
//

#if os(iOS)

import CoreCombine
import Combine
import UIKit

public class ThemeWindow: UIWindow {
	private var themeSubcriber: AnyCancellable?

	public init<T: ThemeType>(windowScene: UIWindowScene, theme: T) {
		super.init(windowScene: windowScene)
		self.overrideUserInterfaceStyle = theme.userInterfaceStyle
	}

	public init<P: CurrentValuePublisher>(windowScene: UIWindowScene, tracking publisher: P) where P.Output: ThemeType {
		super.init(windowScene: windowScene)
		self.overrideUserInterfaceStyle = publisher.value.userInterfaceStyle
		self.themeSubcriber = publisher
			.dropFirst()
			.receive(on: DispatchQueue.mainIfNeeded)
			.sink(receiveCompletion: { [weak self] _ in
				guard let self = self else { return }
				self.themeSubcriber = nil
			}, receiveValue: { [weak self] theme in
				guard let self = self else { return }
				UIView.transition(with: self, duration: 0.33, options: .transitionCrossDissolve) {
					self.overrideUserInterfaceStyle = theme.userInterfaceStyle
				}
			})
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public func track<P: Publisher>(publisher: P) where P.Output: ThemeType {
		self.themeSubcriber = publisher
			.receive(on: DispatchQueue.mainIfNeeded)
			.sink(receiveCompletion: { [weak self] _ in
				guard let self = self else { return }
				self.themeSubcriber = nil
			}, receiveValue: { [weak self] theme in
				guard let self = self else { return }
				self.overrideUserInterfaceStyle = theme.userInterfaceStyle
			})
	}
}

#endif
