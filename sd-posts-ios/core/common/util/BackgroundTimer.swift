//
//  BackgroundTimer.swift
//  sd-posts-ios
//
//  Created by Shohin Tagaev on 7/29/19.
//  Copyright © 2019 super-dispatch. All rights reserved.
//

import Foundation

final public class BackgroundTimer {
    private enum State {
        case suspended
        case resumed
    }
    
    private var state: State = .suspended
    
    public var eventHandler: (() -> Void)?
    
    public let timeInterval: TimeInterval
    public let isRepeating: Bool
    public init(timeInterval: TimeInterval,
                isRepeating: Bool) {
        self.timeInterval = timeInterval
        self.isRepeating = isRepeating
    }
    
    private lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource()
        let r = self.isRepeating ? self.timeInterval : .infinity
        t.schedule(deadline: .now() + self.timeInterval, repeating: r)
        t.setEventHandler(handler: { [weak self] in
            self?.eventHandler?()
        })
        return t
    }()
    
    public func resume() {
        if self.state == .resumed {
            return
        }
        self.state = .resumed
        self.timer.resume()
    }
    
    public func suspend() {
        if self.state == .suspended {
            return
        }
        self.state = .suspended
        self.timer.suspend()
    }
    
    deinit {
        self.timer.setEventHandler {}
        self.timer.cancel()
        
        self.resume()
        self.eventHandler = nil
    }
    
}
