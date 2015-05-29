//
//  image.h
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <UIKit/UIKit.h>

 UIImage*		SquareImage				(UIImage *image, CGFloat size);
UIImage*		ResizeImage				(UIImage *image, CGFloat width, CGFloat height);
UIImage*		CropImage				(UIImage *image, CGFloat x, CGFloat y, CGFloat width, CGFloat height);
