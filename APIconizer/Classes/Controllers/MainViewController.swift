//
//  MainViewController.swift
//  APIconizer
//
//  Created by Warren Gavin on 01/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var tabView: NSTabView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let platforms: [Platform] = [.iOS, .macOS, .watchOS]
        platforms.forEach {
            guard let viewController = NSStoryboard.main.instantiateController(withIdentifier: $0.sceneIdentifier) as? NSViewController else {
                return
            }
            
            let tabItem = NSTabViewItem(viewController: viewController)
            tabItem.label = $0.rawValue
            tabView.addTabViewItem(tabItem)
        }
    }
    
    @IBAction func openPDFDocument(_ sender: Any) {
        let openPanel = NSOpenPanel()
        
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowsMultipleSelection = false
        openPanel.allowedFileTypes = [.pdfExtension]
        
        openPanel.begin { [unowned self] _ in
            self.tabView.tabViewItems.flatMap { $0.viewController as? GeneratedImageViewController }
                                     .forEach { $0.pdfURL = openPanel.url }
        }
    }
}

private extension String {
    static let pdfExtension = "pdf"
}
