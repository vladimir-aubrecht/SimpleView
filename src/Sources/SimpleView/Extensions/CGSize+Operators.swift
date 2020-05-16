//
//  CGSize+Operators.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 16/03/2018.
//

import Foundation

extension CGSize
{
    public static func -(left: CGSize, right: CGSize) -> CGSize
    {
        return CGSize(width: left.width - right.width, height: left.height - right.height)
    }
}
