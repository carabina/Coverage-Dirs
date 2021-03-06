//
//  AppDelegate.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let windowController =  StoryboardScene.Views.initialScene.instantiate()

        windowController.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func inputJSONSelected(_ sender: NSMenuItem) {
        NotificationCenter.default.post(name: .inputJSONSelected,
                                        object: nil)
    }

    @IBAction func openDocument(_ sender: AnyObject) {
        NotificationCenter.default.post(name: .openDocument,
                                        object: nil)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}

extension NSNotification.Name {
    static let inputJSONSelected = NSNotification.Name(rawValue: "inputJSONSelected")
    static let openDocument = NSNotification.Name(rawValue: "openDocument")
}
