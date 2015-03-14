//
//  ResponseMessageList.h
//  Glavhimchistka
//
//  Created by Admin on 14.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "MessageListElements.h"
#import "JSONModel.h"

@interface ResponseMessageList : JSONModel
@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@property(nonatomic,strong)NSMutableArray<MessageListElements>*childNode_comments;
@end
