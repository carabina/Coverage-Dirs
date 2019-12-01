//
//  MainSplitViewController.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 24.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController {

    private weak var sidebarVC: SidebarViewController? {
        didSet {
            self.sidebarVC?.targets = self.targets
        }
    }
    private weak var coverageVC: CoverageViewController?

    var targets: [CoverageTarget] = [] {
        didSet {
            self.sidebarVC?.targets = self.targets
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let sidebarVC = self.children.first as? SidebarViewController {
            self.sidebarVC = sidebarVC
            sidebarVC.delegate = self
        }

        if let coverageVC = self.children.last as? CoverageViewController {
            self.coverageVC = coverageVC
        }
    }

    override func viewDidAppear() {
        super.viewDidAppear()

        let pasteVC = StoryboardScene.Views.jsonPaste.instantiate()

        pasteVC.delegate = self

        self.presentAsSheet(pasteVC)
    }

    private func parseJson(_ jsonString: String) {
        let data = try? XCCovParser.parse(jsonString: jsonString)

        self.targets = data ?? []
    }
}

extension MainSplitViewController: SidebarViewControllerDelegate {
    func sidebarDidSelect(target: CoverageTarget) {
        self.coverageVC?.rootDirectory = target.rootDirectory
    }
}

extension MainSplitViewController: JsonPasteViewControllerDelegate {
    func jsonPasted(_ json: String) {
        self.parseJson(json)
    }
}