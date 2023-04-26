//
//  Navigation.swift
//  UnSplashSample
//
//  Created by Adrian on 26/4/23.
//

import UIKit

class Navigation {
    private let name: String
    private let bundle: Bundle

    public init(name: String, bundle: Bundle = .main) {
        self.name = name
        self.bundle = bundle
    }

    public func initialViewController<T>() -> T {
        let uiStoryboard = UIStoryboard(name: name, bundle: bundle)
        return uiStoryboard.instantiateInitialViewController() as! T
    }

    public func instantiateViewController<T>(
        _ viewControllerIdentifier: String = String(describing: T.self)
    ) -> T {
        let uiStoryboard = UIStoryboard(name: name, bundle: bundle)
        return uiStoryboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as! T
    }
}
