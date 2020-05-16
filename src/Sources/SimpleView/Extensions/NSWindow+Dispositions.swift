//
//  NSWindowExtensions.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 14/08/2017.
//
//

import Cocoa

extension NSWindow
{
    open func positionWindowAtCenter()
    {
        var xPos = NSWidth(self.screen!.frame)/2 - NSWidth(self.frame)/2
        var yPos = NSHeight(self.screen!.frame)/2 - NSHeight(self.frame)/2
        
        let statusBar = NSStatusBar.system
        
        if (!statusBar.isVertical)
        {
            yPos += statusBar.thickness
        }
        else
        {
            xPos += statusBar.thickness
        }
        
        let frame = NSMakeRect(xPos, yPos, NSWidth(self.frame), NSHeight(self.frame))
        self.setFrame(frame, display: true)
    }
    
    open func setWindowSizeWithRespectToMinimumDimension(size : NSSize, minimalDimension : CGFloat)
    {
        var windowSize = size
        
        if windowSize.getBiggerDimension() < minimalDimension
        {
            windowSize = windowSize.getAdjustedSizeByBiggestDimension(minimalBiggestDimension: minimalDimension)
        }
        
        if self.styleMask.contains(.fullScreen) {
            self.setContentSize(self.frame.size)
        }
        else {
            self.setContentSize(windowSize)
        }
    }

    open func setWindowTitleByFilename(fromPath: String)
    {
        self.title = (fromPath as NSString).lastPathComponent
    }
    
    open func isSizeFittingWindow(size: NSSize) -> Bool
    {
        return size < self.frame.size
    }
    
    open func getSizeFittingTheWindow(size: NSSize) -> NSSize
    {
        if isSizeFittingWindow(size: size)
        {
            return size
        }
        
        return self.frame.size
    }
}
