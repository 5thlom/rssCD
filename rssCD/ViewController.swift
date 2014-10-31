//
//  ViewController.swift
//  rssCD
//
//  Created by Zhihua Yang on 10/30/14.
//  Copyright (c) 2014 Zhihua Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var descLabel: UITextView!
    @IBOutlet weak var titleTextF: UITextView!
    
    
    
    var task: Feeds? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        descLabel.text  = task?.desc
        titleTextF.text = task?.title
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
