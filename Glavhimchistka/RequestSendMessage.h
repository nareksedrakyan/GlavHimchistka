//
//  RequestSendMessage.h
//  Glavhimchistka
//
//  Created by Admin on 14.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface RequestSendMessage : JSONModel

@property(nonatomic,strong,getter=getId,setter=setId:)NSString*id;
@property(nonatomic,strong)NSString*dttm;
@property(nonatomic,strong)NSString*mes_type;
@property(nonatomic,strong)NSString*comment;


@end
