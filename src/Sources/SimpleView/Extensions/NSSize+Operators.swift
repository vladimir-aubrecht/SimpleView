//
//  NSSize+operators.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 20/09/2017.
//

import Cocoa

extension NSSize
{
    public func getAdjustedSizeByBiggestDimension(minimalBiggestDimension: CGFloat) -> NSSize
    {
        if self.width >= self.height
        {
            return NSSize(width: minimalBiggestDimension, height: self.height * (minimalBiggestDimension / self.width))
        }

        return NSSize(width: self.width * (minimalBiggestDimension / self.height), height: minimalBiggestDimension)
    }
    
    public func getBiggerDimension() -> CGFloat
    {
        return self.width >= self.height ? self.width : self.height
    }
    
    public static func /(left: NSSize, right: CGFloat) -> NSSize
    {
        let multiplier = 1.0 / right
        
        return left * multiplier
    }
    
    public static func /(left: NSSize, right: NSSize) -> NSSize
    {
        return left * NSSize(width: 1.0 / right.width, height: 1.0 / right.height)
    }
    
    public static func *(left: NSSize, right: NSSize) -> NSSize
    {
        return NSSize(width: left.width * right.width, height: left.height * right.height)
    }
    
    public static func *(left: NSSize, right: CGFloat) -> NSSize
    {
        return NSSize(width: left.width * right, height: left.height * right)
    }
    
    public static func <(left: NSSize, right: NSSize) -> Bool
    {
        return left.width < right.width && left.height < right.height
    }
    
    public static func <=(left: NSSize, right: NSSize) -> Bool
    {
        return left.width <= right.width && left.height <= right.height
    }
}
