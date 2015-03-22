//
//  UserInfo.m
//  Glavhimchistka
//
//  Created by Admin on 14.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "UserInfo.h"
static UserInfo* obj;
@implementation UserInfo
+(void)setUserInfo:(id)object
{
    obj=object;
}

+(UserInfo*)sharedUserInfo
{
    
    if (obj == nil)
    {
        
        obj = [[super alloc] init];
//        obj.sessionID=//@"E2E5C540-E7BD-407A-9EFD-32B5967BAB42";
//        [[NSUserDefaults standardUserDefaults]stringForKey:@"Session_id"];
        
    }
    
    return obj;
}


@end
