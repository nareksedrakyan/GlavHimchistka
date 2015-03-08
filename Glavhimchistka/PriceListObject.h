//
//  PriceListObject.h
//  Glavhimchistka
//
//  Created by Admin on 08.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol PriceListObject @end
#import "JSONModel.h"

@interface PriceListObject : JSONModel<NSCopying>

@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*unit;
@property(nonatomic,strong)NSString*price;

@end
