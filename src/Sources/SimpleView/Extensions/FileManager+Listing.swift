//
//  Filemanager+listing.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 14/08/2017.
//
//

import Cocoa

extension FileManager
{
    open func getFilenamesInFolderOfPath(path: String) -> ([String], String?)
    {
        var folderPath : String? = nil
        var currentFilePath : String? = nil
        
        var isDir : ObjCBool = false
        if self.fileExists(atPath: path, isDirectory:&isDir)
        {
            if isDir.boolValue
            {
                folderPath = path
            }
            else
            {
                folderPath = (path as NSString).deletingLastPathComponent
                currentFilePath = path
            }
            
            let files = try? self.contentsOfDirectory(atPath: folderPath!)
            
            if files == nil
            {
                if isDir.boolValue
                {
                    return ([], nil)
                }
                else
                {
                    return ([path], path)
                }
            }
            
            return (files!.map { folderPath! + "/" + $0 }, currentFilePath)
        }
        
        return ([], nil)
    }
}
