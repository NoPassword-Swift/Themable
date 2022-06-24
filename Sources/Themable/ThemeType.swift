//
//  ThemeType.swift
//  Themable
//

#if os(iOS)
import UIKit
#endif

#if os(macOS)
import AppKit
#endif

public protocol ThemeType {
#if os(iOS)
	var userInterfaceStyle: UIUserInterfaceStyle { get }
#endif

#if os(macOS)
	var appearance: NSAppearance? { get }
#endif
}
