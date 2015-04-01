//
//  ResponseSendMessage.h
//  Glavhimchistka
//
//  Created by Admin on 14.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface ResponseSendMessage : JSONModel

@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@property(strong,nonatomic,getter=getId)NSString*id;
@end
