//
//  PreviewImage_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 18/8/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class PreviewImage_VC: UIViewController {
    
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var image_view: UIImageView!
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scroll_view.maximumZoomScale = 4
        scroll_view.minimumZoomScale = 1
        scroll_view.delegate = self
        image_view.image = image
    }
}

extension PreviewImage_VC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image_view
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = image_view.image {
                let ratioW = image_view.frame.width / image.size.width
                let ratioH = image_view.frame.height / image.size.height
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth * scroll_view.zoomScale > image_view.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - image_view.frame.width : (scroll_view.frame.width - scroll_view.contentSize.width))
                let conditioTop = newHeight*scroll_view.zoomScale > image_view.frame.height
                let top = 0.5 * (conditioTop ? newHeight - image_view.frame.height : (scroll_view.frame.height - scroll_view.contentSize.height))
                
                scroll_view.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        }
        else {
            scroll_view.contentInset = .zero
        }
    }
}
