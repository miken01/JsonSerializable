//
//  JsonSerializable.swift
//  VoiceApp
//
//  Created by Mike Neill on 12/23/16.
//  Copyright © 2016 Spuddmobile. All rights reserved.
//

import Foundation

//MARK: - Protocol

protocol JsonSerializable {
    init(jsonData: [String: AnyObject]) throws
}

//MARK: - Errors

enum JsonSerializableError: Error {
    case Empty
    case InvalidInputData
}

//MARK: - Custom Operators

prefix operator <-?
prefix operator <-!

infix operator <-?
infix operator <-!

extension Dictionary {
    
    //MARK: - Optional Binding
    
    // Infix
    
    static func <-? <T> (left: Dictionary, right: Key) -> T? {
        return left[right] as? T
    }
    
    static func <-? <T: JsonSerializable>(left: Dictionary, right: Key) -> T? {
        
        do {
            return try left<-!right
        } catch {
            return nil
        }
    }
    
    static func <-? <T: JsonSerializable>(left: Dictionary, right: Key) -> [T]? {
        
        guard let array = left[right] as? [[String : AnyObject]] else {
            return nil
        }
        
        var objects = [T]()
        
        for d in array {
            
            do {
                let c = try T(jsonData: d)
                objects.append(c)
            } catch {
                // do nothing
            }
        }
        
        if objects.count > 0 {
            return objects
        }
        
        return nil
    }
    
    //MARK: - Forced Binding
    
    // Infix
    
    static func <-! <T> (left: Dictionary, right: Key) throws -> T {
        
        guard let v = left[right] as? T else {
            throw JsonSerializableError.Empty
        }
        
        return v
    }
    
    static func <-! <T: JsonSerializable>(left: Dictionary, right: Key) throws -> T {
        
        guard let d = left[right] as? [String: AnyObject] else {
            throw JsonSerializableError.Empty
        }
        
        return try T(jsonData: d)
    }
    
    static func <-! <T: JsonSerializable>(left: Dictionary, right: Key) throws -> [T] {
        
        guard let array = left[right] as? [[String : AnyObject]] else {
            throw JsonSerializableError.Empty
        }
        
        var objects = [T]()
        
        for d in array {
            let c = try T(jsonData: d)
            objects.append(c)
        }
        
        return objects
    }
}

extension Array where Element: Collection {
    
    // Optional Binding
    
    // Prefix
    
    static prefix func <-? <T: JsonSerializable>(array: Array) -> [T]? {
        
        var objs = [T]()
        
        for o in array {
            
            guard let d = o as? [String: AnyObject] else {
                continue
            }
            
            do {
                let obj = try T(jsonData: d)
                objs.append(obj)
                
            } catch {
                continue
            }
        }
        
        if objs.count == 0 {
            return nil
        }
        
        return objs
    }
    
    // Forced Binding
    
    // Prefix
    
    static prefix func <-! <T: JsonSerializable>(array: Array) throws -> [T] {
        
        var objs = [T]()
        
        for o in array {
            
            guard let d = o as? [String: AnyObject] else {
                throw JsonSerializableError.InvalidInputData
            }
            
            let obj = try T(jsonData: d)
            objs.append(obj)
        }
        
        return objs
    }
}
