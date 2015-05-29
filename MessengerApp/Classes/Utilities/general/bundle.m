//
//  bundle.m
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//
#import "bundle.h"

 NSString* Applications(NSString *file)
 {
	NSString *path = [[NSBundle mainBundle] resourcePath];
	if (file != nil) path = [path stringByAppendingPathComponent:file];
	return path;
}

 NSString* Documents(NSString *file)
 {
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	if (file != nil) path = [path stringByAppendingPathComponent:file];
	return path;
}

 NSString* Caches(NSString *file)
 {
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	if (file != nil) path = [path stringByAppendingPathComponent:file];
	return path;
}
