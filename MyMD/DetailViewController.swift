//
//  DetailViewController.swift
//  MyMD
//
//  Created by Jay on 2018/1/26.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit
import MarkdownView

class DetailViewController: UIViewController {

    public var filePath : String?;
    
    private var markdownView : MarkdownView!
    private var loadFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        markdownView = MarkdownView.init()
        view.addSubview(markdownView)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        markdownView.frame = view.bounds;
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        guard let _ = filePath else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        if !loadFlag {
            loadFlag = true
            let content = try? String.init(contentsOfFile: filePath!)
            markdownView.load(markdown: content, enableImage: true)
        }
    }
    
    

}
