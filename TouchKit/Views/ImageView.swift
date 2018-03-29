//
//  ImageView.swift
//  TouchKit
//
//  Created by Mario Canto on 3/28/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit

public class ImageView: UIImageView {


	public var fixedContentSize: CGSize? {
		didSet {
			invalidateIntrinsicContentSize()
		}
	}
	
	override public var intrinsicContentSize: CGSize {
		guard let img = image else {
			return CGSize(width: 88, height: 88)
		}
		guard let size = fixedContentSize else {
			return img.size
		}
		return size
	}

}
