//
//  FileBrowser.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 31/07/2017.
//  Copyright © 2017 Vladimir Aubrecht. All rights reserved.
//

import Cocoa

import SwiftyBeaver

class FileBrowser
{
    private var currentPathIndex = 0
    private var filePaths : [String]? = nil
    private let log = SwiftyBeaver.self
    
    private var allowedExtensions : [String]
    
    public init(allowedExtensions : [String])
    {
        self.allowedExtensions = allowedExtensions
    }
    
    internal func clearPaths()
    {
        log.debug("Clearing all paths.")
        self.currentPathIndex = 0
        self.filePaths = nil
    }
    
    public func loadPathsFromPath(path: String)
    {
        log.debug("Trying to load new path.")
        self.clearPaths()
        
        let (filePaths, currentFilePath) = FileManager.default.getFilenamesInFolderOfPath(path: path)
        
        self.filePaths = filePaths.filter({ self.allowedExtensions.contains(($0 as NSString).pathExtension.lowercased()) }).sorted()
        
        if currentFilePath != nil
        {
            self.currentPathIndex = self.filePaths!.index(of: currentFilePath!)!
            
            log.debug("Selected index is: " + String(self.currentPathIndex))
        }
    }
    
    public func deleteCurrentPath()
    {
        if let pathToDelete = self.getCurrentPath()
        {
            log.debug("Trying to delete file.")
            if FileManager.default.isDeletableFile(atPath: pathToDelete)
            {
                log.debug("File is deletable.")

                try! FileManager.default.removeItem(atPath: pathToDelete)
                
                log.debug("File is deleted.")
                
                if self.nextPath()
                {
                    loadPathsFromPath(path: self.getCurrentPath()!)
                }
                else if self.previousPath()
                {
                    loadPathsFromPath(path: self.getCurrentPath()!)
                }
                else
                {
                    clearPaths()
                }
            }
        }
    }
    
    public func getAllPaths() -> [String]?
    {
        return self.filePaths
    }
    
    public func getCurrentPathIndex() -> Int
    {
        return self.currentPathIndex;
    }
    
    public func getCurrentPath() -> String?
    {
        if (self.filePaths?.count == 0) {
            log.debug("No files loaded.")
            return nil
        }
        
        log.debug("Accessing file on index: " + String(self.currentPathIndex))
        return self.filePaths![self.currentPathIndex]
    }
    
    public func goToFirstPath() -> Bool
    {
        log.debug("Trying to go to first path")
        if self.filePaths != nil
        {
            log.debug("Going to first path.")
            self.currentPathIndex = 0;
            return true
        }
        
        return false
    }
    
    public func goToLastPath() -> Bool
    {
        log.debug("Trying to go to last path")
        if self.filePaths != nil
        {
            log.debug("Going to last path.")
            self.currentPathIndex = self.filePaths!.count - 1;
            return true
        }
        
        return false
    }
    
    public func nextPath() -> Bool
    {
        log.debug("Trying to switch to next path.")
        let nextIndex = self.currentPathIndex + 1
        if self.filePaths == nil || nextIndex > self.filePaths!.count - 1
        {
            log.debug("No next path.")
            return false
        }
        
        self.currentPathIndex = nextIndex
        
        return true
    }
    
    public func previousPath() -> Bool
    {
        log.debug("Trying to switch to previous path.")

        let previousIndex = self.currentPathIndex - 1
        if previousIndex < 0
        {
            log.debug("No previous path.")
            return false
        }
        
        self.currentPathIndex = previousIndex
        
        return true
    }
}
