//
//  ServicesElements.h
//  Glavhimchistka
//
//  Created by Admin on 22.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol ServicesElements @end

#import "JSONModel.h"

@interface ServicesElements : JSONModel

@property(nonatomic,strong)NSString*dos_id;
@property(nonatomic,strong)NSString*tov_id;
@property(nonatomic,strong)NSString*service;
@property(nonatomic,strong)NSString*status_id;
@property(nonatomic,strong)NSString*code;

@end
