//
//  ViewController.swift
//  CSV
//
//  Created by 新谷　よしみ on 2017/05/12.
//  Copyright © 2017年 新谷　よしみ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let csvPath = Bundle.main.path(forResource: "sample", ofType: "csv") {
            if let csvStr = try? String(contentsOfFile:csvPath, encoding:String.Encoding.utf8) {
                let csv = CSVParser.parse(csvStr)
                var string = ""
                for (_, row) in csv.enumerated() {
                    for (_, column) in row.enumerated() {
                        string += column + " "
                    }
                    string += "\n"
                }
                textView.text = string
            }
        }
        
//        let csvStr = "aaa,\"bbb\"\r\n\"c\"\"c\",\"d,d\"\r\n\"e\r\ne\",,\"\"\r\n\"f\"ff\"f\",\"g\""
//        let csv = CSVParser.parse(csvStr)
//        var string = ""
//        for (_, row) in csv.enumerated() {
//            for (_, column) in row.enumerated() {
//                string += column + " "
//            }
//            string += "\n"
//        }
//        textView.text = string
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

