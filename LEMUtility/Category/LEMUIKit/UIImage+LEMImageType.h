//
//  UIImage+LEMImageType.h
//  LEMUtility
//
//  Created by Himin on 2018/12/5.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Image file type.
 */
typedef NS_ENUM(NSUInteger, YYImageType) {
    YYImageTypeUnknown = 0, ///< unknown
    YYImageTypeJPEG,        ///< jpeg, jpg
    YYImageTypeJPEG2000,    ///< jp2
    YYImageTypeTIFF,        ///< tiff, tif
    YYImageTypeBMP,         ///< bmp
    YYImageTypeICO,         ///< ico
    YYImageTypeICNS,        ///< icns
    YYImageTypeGIF,         ///< gif
    YYImageTypePNG,         ///< png
    YYImageTypeWebP,        ///< webp
    YYImageTypeOther,       ///< other image format
};

typedef NS_ENUM(NSUInteger, LEMImageType) {
    LEMImageTypeUnknown,
    LEMImageTypePNG,
    LEMImageTypeJPEG,
    LEMImageTypeGIF,
    LEMImageTypeTIFF,
    LEMImageTypeWebP,
};

@interface UIImage (LEMImageType)

+ (LEMImageType)imageTypeWithData:(NSData *)data;
+ (YYImageType)YYImageDetectType:(CFDataRef)data;

@end

NS_ASSUME_NONNULL_END
