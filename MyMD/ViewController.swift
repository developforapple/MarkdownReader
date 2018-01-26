//
//  ViewController.swift
//  MyMD
//
//  Created by Jay on 2018/1/23.
//  Copyright © 2018年 tiny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    public var path : String?
    
    private var files : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if path == nil {
            path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        }
        
        navigationItem.title = (path! as NSString).lastPathComponent;
        
        findFiles()
    }

    private func findFiles(){
        if let a = path , FileManager.default.fileExists(atPath: a) {
            files = try? FileManager.default.contentsOfDirectory(atPath: a)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let a = files {
            return a.count;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell", for: indexPath)
        
        if let a = files {
            let text = a[indexPath.row];
            cell.textLabel?.text = text;
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let p = path , let a = files {
            let fileName = a[indexPath.row];
            let filePath = (p as NSString).appendingPathComponent(fileName)
            
            var isDir : ObjCBool = false;
            if FileManager.default.fileExists(atPath: filePath, isDirectory: &isDir) {
                
                if isDir.boolValue {
                    
                    let sb = UIStoryboard.init(name: "Main", bundle: nil);
                    let vc : ViewController = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController;
                    vc.path = filePath;
                    navigationController?.pushViewController(vc, animated: true);
                    
                }else{
                    
                    if (filePath as NSString).pathExtension == "md" {
                        
                        let sb = UIStoryboard.init(name: "Main", bundle: nil);
                        let detail = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController;
                        detail.filePath = filePath;
                        navigationController?.pushViewController(detail, animated: true)
                        
                    }else{
                        let alert = UIAlertController.init(title: "无法打开", message: "只能打开md后缀的文件", preferredStyle: .alert)
                        navigationController?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }


}

