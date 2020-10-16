//
//  Logger.swift
//  HEB Demo
//
//  Created by Charles Imperato on 10/15/20.
//

import Foundation

import RxSwift
import RxCocoa

enum LogLevel: Int {
    case debug = 0
    case info
    case warning
    case error
}

struct Logger {
    
    /// Configured log level
    static var level: LogLevel = .debug
    
    /// Log a message
    var log: (String, LogLevel) -> Observable<Void>
}

/// - Default live implementation for logging.
extension Logger {
    static let live = Self { message, level in
        Observable<Void>.create { observer in
            if level.rawValue >= Logger.level.rawValue {
                print("Log Message: -> \(message)")
            }

            observer.onNext(())
            observer.onCompleted()
            
            return Disposables.create()
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    }
}

protocol  HasLogger {

    /// - Logger implementation
    var logger: Logger { get }
}
