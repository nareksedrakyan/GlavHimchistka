//
//  MessageListElements.h
//  Glavhimchistka
//
//  Created by Admin on 14.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol MessageListElements @end

#import "JSONModel.h"

@interface MessageListElements : JSONModel

@property(nonatomic,strong)NSString*dttm;
@property(nonatomic,strong)NSString*comment;
@property(nonatomic,strong)NSString*user;
@property(nonatomic,strong)NSString*status_message;

@end
