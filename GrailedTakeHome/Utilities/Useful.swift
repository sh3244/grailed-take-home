//
//  Useful.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/29/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//
//  Some quick and dirty useful classes/functions/extensions

import UIKit

// Debounce should fire newest only
func debounce(milliseconds: Int, queue: DispatchQueue, action: @escaping (() -> Void)) -> () -> Void {
    var lastFireTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.milliseconds(milliseconds)

    return {
        let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay
        // just first immediately if its been at least the dispatch delay (ie a leading debounce)
        guard lastFireTime + dispatchDelay <= dispatchTime else {
            action()
            lastFireTime = DispatchTime.now()
            return
        }

        lastFireTime = DispatchTime.now()
        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + dispatchDelay
            let now = DispatchTime.now()
            if now.rawValue >= when.rawValue {
                action()
            }
        }
    }
}

func throttle(milliseconds: Int, queue: DispatchQueue, action: @escaping (() -> Void)) -> (() -> Void) {
    var dispatchTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.milliseconds(milliseconds)

    return {
        if dispatchTime.rawValue <= DispatchTime.now().rawValue {
            queue.async {
                action()
            }
            dispatchTime = DispatchTime.now() + dispatchDelay
        }
    }
}

typealias Throttle<T> = (_ : T) -> Void
func throttle<T>(interval: Int, queue: DispatchQueue, action: @escaping Throttle<T>) -> Throttle<T> {
    var dispatchTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.seconds(interval)

    return { param in
        if dispatchTime.rawValue <= DispatchTime.now().rawValue {
            queue.async {
                action(param)
            }
            dispatchTime = DispatchTime.now() + dispatchDelay
        }
    }
}

public struct Queue<T> {
    public var array = [T]()

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count
    }

    public mutating func push(_ element: T) {
        array.append(element)
    }

    public mutating func pop() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }

    public mutating func dropFirst() {
        if !isEmpty {
            array.removeFirst()
        }
    }

    public mutating func dropItems(remaining: Int) {
        while array.count > remaining {
            dropFirst()
        }
    }

    public mutating func re() {
        array = []
    }

    public var first: T? {
        return array.first
    }
}

public struct Stack<T> {
    public var array = [T]()

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count
    }

    public mutating func push(_ element: T) {
        array.append(element)
    }

    public mutating func pop() -> T? {
        return array.popLast()
    }

    public var top: T? {
        return array.last
    }
}

extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator {
            return curr.pop()
        }
    }
}

extension Int {
    func valueString() -> String {
        let abbrev = "KMBTPE"
        let result = abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
            let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
            let format = (factor.truncatingRemainder(dividingBy: 1)  == 0 ? "%.0f%@" : "%.1f%@")
            return accum ?? (factor > 1 ? String(format: format, factor, String(tuple.1)) : nil)
            } ?? String(self)
        return result.replacingOccurrences(of: ".0", with: "", options: .literal, range: nil)
    }
}
