//
//  PopupTableViewCell.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 23/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class PopupTableViewCell: UITableViewCell {

    lazy var backView: UIView = {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        return view
    }()
    
    lazy var settingImage: UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 15, y: 13, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = gb.color_main
        return imageView
    }()
    
    lazy var lbl: UILabel = {
       let lbl = UILabel(frame: CGRect(x: 90, y: 0, width: self.frame.width - 80, height: 75))
        lbl.textColor = UIColor.darkGray
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(settingImage)
        backView.addSubview(lbl)
    }

}
