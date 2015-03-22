//
//  ResponseServices.h
//  Glavhimchistka
//
//  Created by Admin on 22.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "ServicesElements.h"
#import "JSONModel.h"

@interface ResponseServices : JSONModel

@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;

@property(strong,nonatomic)NSMutableArray<ServicesElements>*order_servises;

@end
