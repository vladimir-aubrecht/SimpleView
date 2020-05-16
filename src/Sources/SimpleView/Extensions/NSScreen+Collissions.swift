//
//  NSScreen+Collissions.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 20/09/2017.
//

import Cocoa

extension NSScreen
{
    public func isSizeFittingScreen(size: NSSize) -> Bool
    {
        return size < self.frame.size
    }
    
    public func getSizeFittingTheScreen(size: NSSize) -> NSSize
    {
        if isSizeFittingScreen(size: size)
        {
            return size
        }
        
        return self.frame.size
    }
}
