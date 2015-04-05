//
//  MessagesElements.h
//  Glavhimchistka
//
//  Created by Admin on 04.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol MessagesElements @end

#import "JSONModel.h"

@interface MessagesElements : JSONModel
@property(nonatomic,strong,getter=getId,setter=setId:)NSString*id;
@property(nonatomic,strong)NSString*dttm;
@property(nonatomic,strong)NSString*comment;
@property(nonatomic,strong)NSString*message_type;
@property(nonatomic,strong,getter=getNew_mes_count,setter=setNew_mes_count:)NSString*new_mes_count;
@end
