//
//  MainViewController.swift
//  APIconizer
//
//  Created by Warren Gavin on 01/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    @IBOutlet weak var tabView: NSTabView!
    private let platforms: [Platform] = [.iOS, .macOS, .watchOS]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        openPanel.canChooseFiles          = true
        openPanel.canChooseDirectories    = false
        openPanel.allowsMultipleSelection = false
        openPanel.allowedContentTypes     = [.pdf]

        openPanel.begin { [unowned self] _ in
            self.setPDF(at: openPanel.url)
        }
    }
}

extension MainViewController: DragAndDropViewDelegate {
    func setPDF(at url: URL?) {
        tabView
            .tabViewItems
            .compactMap {
                $0.viewController as? GeneratedImageViewController
            }
            .forEach {
                $0.viewModel = PDFViewModel(PDF(url: url))
            }
    }
}
