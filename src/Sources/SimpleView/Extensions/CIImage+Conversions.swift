//
//  CIImage+Conversions.swift
//  SimpleView
//
//  Created by Vladimir Aubrecht on 14/08/2017.
//
//

import Quartz

extension CIImage
{
    open func createCGImage() -> CGImage
    {
        return CIContext().createCGImage(self, from: self.extent)!
    }
}
