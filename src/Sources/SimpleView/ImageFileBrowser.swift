//
//  CachedImageFileBrowser.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 05/03/2018.
//
import Cocoa

class ImageFileBrowser : FileBrowser
{
    private let cacheSize = 4
    private var images : [NSImage?] = [NSImage]()
    
    public override func clearPaths() {
        super.clearPaths()
        
        images = [NSImage]()
    }
    
    public override func loadPathsFromPath(path: String)
    {
        super.loadPathsFromPath(path: path)
        
        if let paths = self.getAllPaths() {
            var index = 0
            for path in paths {
                if index > self.getCurrentPathIndex() - cacheSize && index < self.getCurrentPathIndex() + cacheSize {
                    self.images.append(NSImage(contentsOfFile: path))
                }
                else
                {
                    self.images.append(nil)
                }
                
                index += 1
            }
            
        }
    }
    
    public func getCurrentImage() -> NSImage?
    {
        let index = self.getCurrentPathIndex()
        
        if index >= self.images.count {
            return nil
        }
        
        if self.images[index] == nil {
            self.images[index] = NSImage(contentsOfFile: self.getCurrentPath()!)!
        }
        
        return self.images[index]
    }
    
    public override func goToFirstPath() -> Bool {
        let result = super.goToFirstPath()
        
        if result {
            self.invalidateCache()
        }
        
        return result
    }
    
    public override func goToLastPath() -> Bool {
        let result = super.goToLastPath()
        
        if result {
            self.invalidateCache()
        }
        
        return result
    }
    
    public override func nextPath() -> Bool {
        let result = super.nextPath()
        
        if result {
            self.invalidateCache()
        }
        
        return result
    }
    
    public override func previousPath() -> Bool {
        let result = super.previousPath()
        
        if result {
            self.invalidateCache()
        }

        return result

    }
    
    private func invalidateCache()
    {
        if let paths = self.getAllPaths() {
            let currentIndex = self.getCurrentPathIndex()
            let lastIndex = paths.count - 1;
            let firstEmptyIndex = currentIndex - cacheSize
            let lastEmptyIndex = currentIndex + cacheSize
            
            if firstEmptyIndex >= 0 {
                for index in 0 ... firstEmptyIndex {
                    self.images[index] = nil
                }
            }
            else if -firstEmptyIndex < lastIndex {
                for index in lastIndex + firstEmptyIndex ... lastIndex {
                    self.images[index] = nil
                }
            }
            
            if lastEmptyIndex < lastIndex {
                for index in lastEmptyIndex ... lastIndex {
                    self.images[index] = nil
                }
            } else if lastEmptyIndex - lastIndex < lastIndex {
                for index in 0 ... lastEmptyIndex - lastIndex {
                    self.images[index] = nil
                }
            }
        }
    }
}
