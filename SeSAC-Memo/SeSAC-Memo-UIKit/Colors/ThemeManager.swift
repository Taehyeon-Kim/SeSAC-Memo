//
//  ThemeManager.swift
//  SeSAC-Memo-UIKit
//
//  Created by taekki on 2022/09/05.
//

import UIKit

extension UIColor {
    
    public static func makeColor(from hex: String) -> UIColor {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >>  8) & 0xFF) / 255.0
        let blue = Double((rgb >>  0) & 0xFF) / 255.0
        
        return .init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

public enum Theme: Int {
    case theme1
    
    public var mainColor: UIColor {
        switch self {
        case .theme1:
            return UIColor(named: "background")!
        }
    }
    
    public var pointColor: UIColor {
        switch self {
        case .theme1:
            return UIColor.systemOrange
        }
    }

    public var titleTextColor: UIColor {
        switch self {
        case .theme1:
            return UIColor.label
        }
    }
    
    public var subtitleTextColor: UIColor {
        switch self {
        case .theme1:
            return UIColor.systemGray2
        }
    }
}

extension Theme {
    
    public var backgroundColor: UIColor {
        switch self {
        case .theme1:
            return UIColor(named: "background")!
        }
    }
    
    public var cellBackgroundColor: UIColor {
        switch self {
        case .theme1:
            return UIColor(named: "cellBackground")!
        }
    }
    
    public var popUpBackgroundColor: UIColor {
        switch self {
        case .theme1:
            return UIColor(named: "popUpBackground")!
        }
    }
}

extension Theme {
    
    public var barStyle: UIBarStyle {
        switch self {
        case .theme1:
            return .default
        }
    }

    public var navigationBackgroundImage: UIImage? {
        return self == .theme1 ? UIImage(named: "navBackground") : nil
    }

    public var tabBarBackgroundImage: UIImage? {
        return self == .theme1 ? UIImage(named: "tabBarBackground") : nil
    }
}

public let selectedThemeKey = "theme1"

public class ThemeManager {

    public static func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: selectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .theme1
        }
    }

    public static func applyTheme(theme: Theme) {
        UserDefaults.standard.setValue(theme.rawValue, forKey: selectedThemeKey)
        UserDefaults.standard.synchronize()

        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = theme.mainColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)

        let toolbarAppearance = UIToolbarAppearance()
        toolbarAppearance.configureWithOpaqueBackground()
        toolbarAppearance.backgroundColor = theme.mainColor
        UIToolbar.appearance().standardAppearance = toolbarAppearance
    }
}
