//
//  LoadingView.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 12/06/21.
//

import UIKit

public class LoadingView {
    
    public static let sharedInstance = LoadingView()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()
    
    init() {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.2
        indicator.style = .large
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .gray
    }
    
    func showIndicator(){
        DispatchQueue.main.async( execute: {
            UIApplication.shared.windows.first?.addSubview(self.blurImg)
            UIApplication.shared.windows.first?.addSubview(self.indicator)
        })
    }
    
    func hideIndicator(){
        DispatchQueue.main.async( execute: {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        })
    }
}
