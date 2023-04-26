//
//  KotlinScope.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation

extension Optional {
    func apply(_ block: (Wrapped) -> Void) -> Optional {
           if let value = self {
               block(value)
           }
           return self
       }

    @discardableResult
    func also(_ closure: (Wrapped) throws -> Void) rethrows -> Optional {
          try self.map(closure)
          return self
    }

    func `let`<T>(_ closure: (Wrapped) -> T?) -> T? {
        if let value = self {
            return closure(value)
        }
        return nil
    }

    func run<T>(_ block: (Wrapped) -> T) -> T? {
           return self.map(block)
    }

    func or(_ closure: () -> Wrapped) -> Wrapped {
        if let value = self {
            return value
        } else {
            return closure()
        }
    }
}

extension Optional where Wrapped == String {
    func orEmpty() -> String {
        return self ?? ""
    }
}
