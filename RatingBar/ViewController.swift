//
//  ViewController.swift
//  RatingBar
//
//  Created by Devanshu Saini on 11/02/17.
//  Copyright © 2017 Devanshu Saini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let ratingBar = RatingBarView(frame: CGRect(x: 10.0, y: 80.0, width: 73.0, height: 16.0))
        ratingBar.cellCornerRadius = 6.5
        ratingBar.cellImage = #imageLiteral(resourceName: "star")
        self.view.addSubview(ratingBar)
        ratingBar.renderView()
    }
}

