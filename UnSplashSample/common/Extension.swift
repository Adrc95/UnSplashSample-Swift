//
//  Extension.swift
//  UnSplashSample
//
//  Created by Adrian on 20/4/23.
//

import Foundation

extension String {
    func getString() -> String {
        return NSLocalizedString(self, comment: "")
    }
    func getString(args: CVarArg...) -> String {
        let string = self.getString().replacingOccurrences(of: "$s", with: "$@")
        return String(format: string, args)
    }
}
