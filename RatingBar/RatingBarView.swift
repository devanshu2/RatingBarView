//
//  RatingBarView.swift
//  RatingBar
//
//  Created by Devanshu Saini on 11/02/17.
//  Copyright © 2017 Devanshu Saini. All rights reserved.
//

import UIKit

class RatingBarView: UIView {
    
    public var cellCornerRadius:CGFloat = 3.0 {
        didSet {
            self.singleCellBasicSettingsUpdates()
        }
    }
    public var selectionColor:UIColor = .green {
        didSet {
            self.singleCellBasicSettingsUpdates()
        }
    }
    public var defaultColor:UIColor = .gray {
        didSet {
            self.singleCellBasicSettingsUpdates()
        }
    }
    public var cellImage:UIImage?
    public var cellWidth:CGFloat = 13.0
    public var cellSeparation:CGFloat = 2.0
    public var rating:Int = 0 {
        didSet {
            self.singleCellBasicSettingsUpdates()
        }
    }
    
    private func singleCellBasicSettingsUpdates() {
        if self.wrapperView != nil {
            for index in 1...5 {
                if let singleCell = self.wrapperView!.viewWithTag(index) as? UIImageView {
                    singleCell.layer.cornerRadius = self.cellCornerRadius
                    singleCell.backgroundColor = self.defaultColor
                    if self.rating >= index {
                        singleCell.backgroundColor = self.selectionColor
                    }
                }
            }
        }
    }
    
    var wrapperView:UIView?
    var resizedCellImage:UIImage?
    
    public func renderView() {
        self.addWrapperView()
        self.setupCells()
    }
    
    private func setupCells() {
        self.resizeCellImageIfNeeded()
        var lastImageView:UIImageView?
        for index in 1...5 {
            let singleCell = UIImageView()
            singleCell.translatesAutoresizingMaskIntoConstraints = false
            singleCell.tag = index
            singleCell.clipsToBounds = true
            singleCell.layer.cornerRadius = self.cellCornerRadius
            singleCell.contentMode = .center
            singleCell.backgroundColor = self.defaultColor
            if self.rating >= index {
                singleCell.backgroundColor = self.selectionColor
            }
            if self.resizedCellImage != nil {
                singleCell.image = self.resizedCellImage
            }
            
            self.wrapperView?.addSubview(singleCell)
            let top = NSLayoutConstraint(item: singleCell,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: self.wrapperView,
                                         attribute: .top,
                                         multiplier: 1.0,
                                         constant: 0.0)
            let bottom = NSLayoutConstraint(item: singleCell,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: self.wrapperView,
                                            attribute: .bottom,
                                            multiplier: 1.0,
                                            constant: 0.0)
            let width = NSLayoutConstraint(item: singleCell,
                                           attribute: .width,
                                           relatedBy: .equal,
                                           toItem: nil,
                                           attribute: .notAnAttribute,
                                           multiplier: 1.0,
                                           constant: self.cellWidth)
            
            NSLayoutConstraint.activate([width, top, bottom])
            if lastImageView != nil {
                let leading = NSLayoutConstraint(item: singleCell,
                                                 attribute: .left,
                                                 relatedBy: .equal,
                                                 toItem: lastImageView,
                                                 attribute: .right,
                                                 multiplier: 1.0,
                                                 constant: CGFloat(self.cellSeparation))
                NSLayoutConstraint.activate([leading])
            }
            else {
                let leading = NSLayoutConstraint(item: singleCell,
                                                 attribute: .leading,
                                                 relatedBy: .equal,
                                                 toItem: self.wrapperView,
                                                 attribute: .leading,
                                                 multiplier: 1.0,
                                                 constant: 0.0)
                NSLayoutConstraint.activate([leading])
            }
            lastImageView = singleCell
        }
    }
    
    private func addWrapperView() {
        if self.wrapperView != nil {
            self.wrapperView?.removeFromSuperview()
            self.wrapperView = nil
        }
        self.wrapperView = UIView()
        self.wrapperView!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.wrapperView!)
        self.wrapperView?.backgroundColor = .clear
        let leading = NSLayoutConstraint(item: self.wrapperView!,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1.0,
                                         constant: 0.0)
        let trailing = NSLayoutConstraint(item: self.wrapperView!,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .trailing,
                                          multiplier: 1.0,
                                          constant: 0.0)
        let top = NSLayoutConstraint(item: self.wrapperView!,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: 0.0)
        let bottom = NSLayoutConstraint(item: self.wrapperView!,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
    
    private func resizeCellImageIfNeeded() {
        if self.cellImage != nil {
            self.setNeedsLayout()
            self.layoutIfNeeded()
            let oH = Double((self.cellImage?.size.height)!)
            let oW = Double((self.cellImage?.size.width)!)
            let ratio = oW/oH
            let tH = Double(self.bounds.size.height - 2.0)
            let tW = Double(self.cellWidth - 2.0)
            self.resizedCellImage = self.cellImage
            if oH > tH || oW > tW {
                var h = tH
                var w = h * ratio
                if h > tH || w > tW {
                    w = tW
                    h = w / ratio
                }
                self.resizedCellImage = self.imageWithImage(image: self.resizedCellImage!, scaledToSize: CGSize(width: w, height: h))
            }
        }
    }
    
    private func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
