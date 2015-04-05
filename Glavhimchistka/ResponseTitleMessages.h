//
//  ResponseTitleMessages.h
//  Glavhimchistka
//
//  Created by Admin on 04.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "MessagesElements.h"
#import "JSONModel.h"

@interface ResponseTitleMessages : JSONModel

@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@property(strong,nonatomic)NSMutableArray<MessagesElements>*Messages;

@end
