//
//  ColorToImage.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/07/13.
//

import UIKit

// UIColor를 기반으로 UIImage 생성하고 코너(radius) 값을 적용하는 함수
let cornerRadius = 11.0

func image(withColor color: UIColor) -> UIImage {
    let size = CGSize(width: 1, height: 1)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    
    let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: cornerRadius)
    path.fill()
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}

