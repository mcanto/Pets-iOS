//
//  UIImage+Resize.swift
//  TouchKit
//
//  Created by Mario Canto on 3/28/18.
//  Copyright © 2018 touchtastic. All rights reserved.
//

import UIKit

extension UIImage {
	
	public enum ScalingMode {
		case aspectFill
		case aspectFit
		func aspectRatio(between size: CGSize, and otherSize: CGSize) -> CGFloat {
			let aspectWidth  = size.width/otherSize.width
			let aspectHeight = size.height/otherSize.height
			
			switch self {
			case .aspectFill:
				return max(aspectWidth, aspectHeight)
			case .aspectFit:
				return min(aspectWidth, aspectHeight)
			}
		}
	}
	
	public func scaled(to newSize: CGSize, scalingMode: UIImage.ScalingMode = .aspectFill) -> UIImage {
		
		let aspectRatio = scalingMode.aspectRatio(between: newSize, and: size)
		var scaledImageRect = CGRect.zero
		
		scaledImageRect.size.width  = size.width * aspectRatio
		scaledImageRect.size.height = size.height * aspectRatio
		scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
		scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
		UIGraphicsBeginImageContext(newSize)
		
		draw(in: scaledImageRect)
		let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
		
		return scaledImage!
	}
	
	public func scaled(to maxSize: CGFloat) -> UIImage {
		let aspectRatio = min(maxSize / self.size.width, maxSize / self.size.height)
		let newWidth = CGFloat(round(aspectRatio * self.size.width))
		let newHeight = CGFloat(round(aspectRatio * self.size.height))
		let newSize = CGSize(width: newWidth, height: newHeight)
		return scaled(to: newSize, scalingMode: .aspectFit)
	}
}
