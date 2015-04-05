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
@property(nonatomic,strong)NSString*phone_cell;
@property(nonatomic,strong)NSString*phone;
@property(nonatomic,strong)NSString*email;
@property(nonatomic,strong)NSString*address;
@property(nonatomic,strong)NSString*discount;
@property(nonatomic,strong)NSString*card_code;
@property(nonatomic,strong)NSString*agree_to_receive_sms;
@property(nonatomic,strong)NSString*agree_to_receive_adv_sms;


+(void)setUserInfo:(id)object;
+(UserInfo*)sharedUserInfo;

@end
