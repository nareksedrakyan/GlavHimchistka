//
//  UserInfo.h
//  Glavhimchistka
//
//  Created by Admin on 14.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(nonatomic,strong)NSString*sessionID;
@property(nonatomic,strong)NSString*userName;

+(void)setUserInfo:(id)object;
+(UserInfo*)sharedUserInfo;

@end
