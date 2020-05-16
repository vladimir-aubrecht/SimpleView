//
//  AppDelegate.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 31/07/2017.
//  Copyright © 2017 Vladimir Aubrecht. All rights reserved.
//

import Cocoa
import SwiftyBeaver
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate, NSWindowDelegate
{
    private let log = SwiftyBeaver.self
    
    private var rootViewController : ViewController? = nil
    
    private var mainWindow: NSWindow!
    
    public func menuWillOpen(_ menu: NSMenu)
    {
        menu.toggleMenuItemVisibilityByTagId(tagId: 2)
    }
    
    public func menuDidClose(_ menu: NSMenu)
    {
        menu.toggleMenuItemVisibilityByTagId(tagId: 2)
    }
    
    @IBAction func zoomIn(_ sender: NSMenuItem)
    {
        self.log.debug("Zoom in.")
        self.rootViewController!.zoomInImage()
    }
    
    @IBAction func zoomOut(_ sender: NSMenuItem)
    {
        self.log.debug("Zoom out.")
        self.rootViewController!.zoomOutImage()
    }

    @IBAction private func toggleFullscreen(_ sender: Any)
    {
        let wasFullscreen = self.mainWindow.styleMask.contains(.fullScreen)

        self.mainWindow.toggleFullScreen(nil)
        
        if wasFullscreen {
            self.rootViewController!.reZoom()
        }
    }
    
    @IBAction private func openFolder(_ sender: Any)
    {
        log.debug("Opening folder ...")
        
        let dialog = NSOpenPanel();
        dialog.title = "Select folder of photo which should be opened."
        dialog.allowsMultipleSelection = false;
        dialog.canChooseDirectories = true;
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK)
        {
            NSDocumentController.shared.noteNewRecentDocumentURL(dialog.url!)
            
            self.mainWindow.makeKeyAndOrderFront(nil)
            self.rootViewController!.loadPath(path: dialog.url!.path)
            self.rootViewController!.setWindowLayoutByCurrentImage()
        }
    }
    
    @IBAction private func previousImage(_ sender: Any)
    {
        self.log.debug("Previous image action triggered.")
        self.rootViewController!.previousImage()
    }

    @IBAction private func nextImage(_ sender: Any)
    {
        self.log.debug("Next image action triggered.")
        self.rootViewController!.nextImage()
    }
    
    @IBAction func zoomDefault(_ sender: Any)
    {
        self.log.debug("Zoom default.")
        self.rootViewController!.zoomDefault()
    }

    @IBAction func DeleteFile(_ sender: Any) {
        self.log.debug("Deleting file.")
        self.rootViewController!.deleteCurrentImage()
    }

    public func application(_ sender: NSApplication, openFile filename: String) -> Bool
    {
        self.log.debug("Starting application through associated file")
        
        //self.mainWindow.makeKeyAndOrderFront(nil)
        self.rootViewController!.loadPath(path: filename)
        self.rootViewController!.setWindowLayoutByCurrentImage()
        return true
    }
    
    public func applicationWillFinishLaunching(_ notification: Notification)
    {
        self.log.debug("Starting application normally.")
        self.mainWindow = NSApplication.shared.windows[0]
        
        NSApp.mainMenu!.registerSubmenusDelegate(submenuDelegate: self)
        self.mainWindow.delegate = self
        
        self.rootViewController = (mainWindow.windowController!.contentViewController as! ViewController)
        //self.mainWindow.orderOut(nil) //TODO: Must be way without custom method ...
        
        self.mainWindow.positionWindowAtCenter()
    }
    
    public func windowDidResize(_ notification: Notification) {
        self.rootViewController!.setContentSizeByCurrentImage()
    }
    
}

