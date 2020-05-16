//
//  ViewController.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 31/07/2017.
//  Copyright © 2017 Vladimir Aubrecht. All rights reserved.
//

import Cocoa
import SwiftyBeaver

class SettingsController: NSViewController {
    
    private let log = SwiftyBeaver.self
    
    @IBOutlet weak var autoresizeWindowCheckbox: NSButton!
    
    override func viewWillDisappear() {
        //ApplicationSettings(autoresizeWindow: self.autoresizeWindowCheckbox.isEnabled)
    }
    
}


