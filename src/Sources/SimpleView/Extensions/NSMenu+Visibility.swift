//
//  NSMenu+Visibility.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 14/08/2017.
//
//

import Cocoa

extension NSMenu
{
    open func toggleMenuItemVisibilityByTagId(tagId : Int)
    {
        self.items.filter { item in item.tag == tagId }.forEach { item in item.isHidden = !item.isHidden }
    }
    
    open func registerSubmenusDelegate(submenuDelegate : NSMenuDelegate)
    {
        self.items.forEach { item in item.submenu?.delegate = submenuDelegate}
    }
}
