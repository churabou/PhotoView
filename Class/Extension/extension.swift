//
//  extension.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/04/02.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

extension UIColor {
    class var pink: UIColor {
        return UIColor(red: 1, green: 192/255, blue: 203/255, alpha: 1)
    }
}


extension UIImage {
    
    func cropThumbnailImage() -> UIImage {
        let s = min(size.width, size.height)
        // リサイズ処理
        guard let origRef = cgImage else {
            return UIImage()
        }
        let origWidth  = CGFloat(origRef.width)
        let origHeight = CGFloat(origRef.height)
        var resizeWidth: CGFloat = 0
        var resizeHeight: CGFloat = 0
        
        if (origWidth < origHeight) {
            resizeWidth = s
            resizeHeight = origHeight * resizeWidth / origWidth
        } else {
            resizeHeight = s
            resizeWidth = origWidth * resizeHeight / origHeight
        }
        
        let resizeSize = CGSize(width: resizeWidth, height: resizeHeight)
        
        UIGraphicsBeginImageContext(resizeSize)
        
        draw(in: CGRect(x: 0, y: 0, width: resizeWidth, height: resizeHeight))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 切り抜き処理
        let cropRect  = CGRect(x: (resizeWidth - s) / 2, y: (resizeHeight - s) / 2, width: s, height: s)
        let cropRef   = resizeImage!.cgImage!.cropping(to: cropRect)
        let cropImage = UIImage(cgImage: cropRef!)
        
        return cropImage
    }
}
