//
//  ViewController.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 31/07/2017.
//  Copyright © 2017 Vladimir Aubrecht. All rights reserved.
//

import Cocoa
import SwiftyBeaver
import Quartz

class ViewController: NSViewController {

    private let log = SwiftyBeaver.self
    
    @IBOutlet var OpeningLabel: NSTextField!
    
    @IBOutlet var scrollView: NSScrollView!
    
    @IBOutlet var imageCell: NSImageCell!

    // TODO: Think about moving fileBrowser into AppDelegate (it would removed proxy methods ...)
    private var fileBrowser = ImageFileBrowser(allowedExtensions: ["jpeg", "jpg", "png", "psd", "bmp", "gif", "raw"])
    
    let zoomMultiplier : CGFloat = 1.2
    
    public func loadPath(path: String)
    {
        self.fileBrowser.loadPathsFromPath(path: path)
        self.processCurrentImage()
    }
    
    public func deleteCurrentImage()
    {
        self.fileBrowser.deleteCurrentPath()
        self.processCurrentImage()
    }
    
    public func zoomInImage()
    {
        self.scrollView.magnification *= zoomMultiplier
    }
    
    public func zoomOutImage()
    {
        self.scrollView.magnification /= zoomMultiplier
    }
    
    public func zoomDefault()
    {
        self.scrollView.magnification = 1.0
    }
    
    public func nextImage()
    {
        if (self.fileBrowser.nextPath())
        {
            self.processCurrentImage()
        }
        else if self.fileBrowser.goToFirstPath()
        {
            self.processCurrentImage()
        }
    }
    
    public func previousImage()
    {
        if (self.fileBrowser.previousPath())
        {
            self.processCurrentImage()
        }
        else if self.fileBrowser.goToLastPath()
        {
            self.processCurrentImage()
        }
    }
    
    public func reZoom()
    {
        let magnification = self.scrollView.magnification
        self.zoomDefault()
        self.scrollView.magnification = magnification
    }
    
    private func processCurrentImage()
    {
        self.imageCell.image = self.fileBrowser.getCurrentImage()
        
        self.OpeningLabel.isHidden = self.fileBrowser.getCurrentPath() != nil
        
        if let imagePath = self.fileBrowser.getCurrentPath() {
            
            self.scrollView.window!.setWindowTitleByFilename(fromPath: imagePath)
            self.setContentSizeByCurrentImage()
        }

    }
    
    public func setContentSizeByCurrentImage()
    {
        if self.fileBrowser.getCurrentImage() != nil
        {
            let sizeFittingWindow = self.scrollView.window!.getSizeFittingTheWindow(size: self.imageCell.image!.size)
            self.scrollView.documentView!.setFrameSize(sizeFittingWindow)
            self.zoomDefault()
        }
    }
    
    public func setWindowLayoutByCurrentImage()
    {
        if self.fileBrowser.getCurrentImage() != nil
        {
            let sizeFittingScreen = self.scrollView.window!.screen!.getSizeFittingTheScreen(size: self.imageCell.image!.size)
            self.scrollView.documentView!.setFrameSize(sizeFittingScreen)
            
            self.scrollView.window!.setWindowSizeWithRespectToMinimumDimension(size: sizeFittingScreen, minimalDimension: 500.0)
            self.scrollView.window!.positionWindowAtCenter()
            self.zoomDefault()
        }
    }
}

