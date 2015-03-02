//
//  RegisterNewRequest.h
//  Glavhimchistka
//
//  Created by Admin on 27.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface RegisterNewRequest : JSONModel
@property(nonatomic,strong)NSString*fone;
@property(nonatomic,strong)NSString*mail;
@property(nonatomic,strong)NSString*change_name;
@property(nonatomic,strong)NSString*city;
@property(nonatomic,strong)NSString*street;
@property(nonatomic,strong)NSString*house;
@property(nonatomic,strong)NSString*housing;
@property(nonatomic,strong)NSString*room;
@property(nonatomic,strong)NSString*office;
@property(nonatomic,strong)NSString*comment;
@property(nonatomic,strong)NSString*promocode;
@property(nonatomic,strong)NSString*working_address;
@property(nonatomic,strong)NSString*Source;
@end
