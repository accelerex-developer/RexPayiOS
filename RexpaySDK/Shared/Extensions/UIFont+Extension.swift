//
//  UIFont+Extension.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import UIKit

extension UIFont {

    static func poppinsBold(size: CGFloat = 14) -> UIFont { UIFont(name: "Poppins-Bold", size: size) ?? UIFont.systemFont(ofSize: size) }

    static func poppinsRegular(size: CGFloat = 14) -> UIFont { UIFont(name: "Poppins-Regular", size: size) ?? UIFont.systemFont(ofSize: size) }
    
    static func nunitoSansSemiBold(size: CGFloat = 14) -> UIFont { UIFont(name: "NunitoSans-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size) }

    static func poppinsExtraBold(size: CGFloat = 14) -> UIFont { UIFont(name: "Poppins-ExtraBold", size: size)! }
    
    static func poppinsExtraBoldItalic(size: CGFloat = 14) -> UIFont { UIFont(name: "Poppins-ExtraBoldItalic", size: size)! }
}

extension CGSize {
    
    init(height: CGFloat) {
        self.init(width: 0, height: height)
    }
    
    init(width: CGFloat) {
        self.init(width: width, height: 0)
    }
}

extension UIFont {
    
    static func registerAllFonts(bundle: Bundle) {

        jbs_registerFont(
            withFilenameString: "Poppins-Black.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-BlackItalic.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-Bold.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-BoldItalic.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-ExtraBold.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-ExtraBoldItalic.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-ExtraLight.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-ExtraLightItalic.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-Italic.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-Light.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-LightItalic.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-Medium.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-MediumItalic.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-Regular.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-SemiBold.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-SemiBoldItalic.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-Thin.ttf",
            bundle: bundle
        )
        
        jbs_registerFont(
            withFilenameString: "Poppins-ThinItalic.ttf",
            bundle: bundle
        )
        
    }

    static func jbs_registerFont(withFilenameString filenameString: String, bundle: Bundle) {
        print(" filename \(filenameString) bundle \(bundle)")
       guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
           print("UIFont+:  Failed to register font - path for resource not found.")
           return
       }

       guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
           print("UIFont+:  Failed to register font - font data could not be loaded.")
           return
       }

       guard let dataProvider = CGDataProvider(data: fontData) else {
           print("UIFont+:  Failed to register font - data provider could not be loaded.")
           return
       }

       guard let font = CGFont(dataProvider) else {
           print("UIFont+:  Failed to register font - font could not be loaded.")
           return
       }

       var errorRef: Unmanaged<CFError>? = nil
       if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
           print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
       }
   }

}
