//
//  NoBatteryPercent.x
//  NoBatteryPercent
//
//  Created by Jonas Gessner on 22.08.2014.
//  Copyright (c) 2014 Jonas Gessner. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <substrate.h>

%group main

%hook UIStatusBarBatteryPercentItemView

- (BOOL)updateForNewData:(id)arg1 actions:(int)arg2 {
    BOOL up = %orig;
    
    NSString *str = MSHookIvar<NSString *>(self, "_percentString");
    
    NSMutableString *mutableStr = nil;
    
    while ((mutableStr ? [mutableStr hasSuffix:@"%"] || [mutableStr hasSuffix:@" "] : [str hasSuffix:@"%"])) {
        if (!mutableStr) {
            mutableStr = str.mutableCopy;
        }
        
        [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length-1, 1)];
    }
    
    if (mutableStr) {
        MSHookIvar<NSString *>(self, "_percentString") = mutableStr.copy;
    }
    
    return up;
}

%end

%end


%ctor {
	@autoreleasepool {
		%init(main);
	}
}
