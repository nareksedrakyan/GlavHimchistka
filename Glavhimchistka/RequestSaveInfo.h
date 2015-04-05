//
//  RequestSaveInfo.h
//  Glavhimchistka
//
//  Created by Admin on 05.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface RequestSaveInfo : JSONModel

@property(nonatomic,strong)NSString*Name;
@property(nonatomic,strong)NSString*Fone;
@property(nonatomic,strong)NSString*Teleph_cell;
@property(nonatomic,strong)NSString*Email;
@property(nonatomic,strong)NSString*Address;
@property(nonatomic,strong)NSString*sourse;

@end
