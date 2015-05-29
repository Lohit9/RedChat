//
//  converter.m
//  MessengerApp
//
//  Created by Lohit Talasila on 2015-04-27.
//  Copyright (c) 2015 Lohit Talasila. All rights reserved.
//

#import "converter.h"

 NSString* Date2String(NSDate *date)
 {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'"];
	[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	return [formatter stringFromDate:date];
}

 NSDate* String2Date(NSString *dateStr)
 {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'zzz'"];
	[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	return [formatter dateFromString:dateStr];
}

 NSString* TimeElapsed(NSTimeInterval seconds)
 {
	NSString *elapsed;
	if (seconds < 60)
	{
		elapsed = @"Just now";
	}
	else if (seconds < 60 * 60)
	{
		int minutes = (int) (seconds / 60);
		elapsed = [NSString stringWithFormat:@"%d %@", minutes, (minutes > 1) ? @"mins" : @"min"];
	}
	else if (seconds < 24 * 60 * 60)
	{
		int hours = (int) (seconds / (60 * 60));
		elapsed = [NSString stringWithFormat:@"%d %@", hours, (hours > 1) ? @"hours" : @"hour"];
	}
	else
	{
		int days = (int) (seconds / (24 * 60 * 60));
		elapsed = [NSString stringWithFormat:@"%d %@", days, (days > 1) ? @"days" : @"day"];
	}
	return elapsed;
}
