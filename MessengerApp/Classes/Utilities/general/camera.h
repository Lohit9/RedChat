//
//  camera.h
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import <UIKit/UIKit.h>

 BOOL			PresentPhotoCamera		(id target, BOOL canEdit);
BOOL			PresentVideoCamera		(id target, BOOL canEdit);
BOOL			PresentMultiCamera		(id target, BOOL canEdit);

 BOOL			PresentPhotoLibrary		(id target, BOOL canEdit);
BOOL			PresentVideoLibrary		(id target, BOOL canEdit);
