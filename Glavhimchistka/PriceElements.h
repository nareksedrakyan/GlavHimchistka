//
//  PriceElements.h
//  Glavhimchistka
//
//  Created by Admin on 07.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol PriceElements @end
#import "JSONModel.h"

@interface PriceElements : JSONModel<NSCopying>

@property(nonatomic,assign,getter=getId)NSInteger id;

@property(nonatomic,strong)NSString*code;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*unit;
@property(nonatomic,strong)NSString*price;
@property(nonatomic,strong)NSString*group_p;
@property(nonatomic,strong)NSString*group_c;
@property(nonatomic,strong)NSString*price_id;
@property(nonatomic,strong)NSString*top_parent;
@property(nonatomic,strong)NSString*order_addon_pack_id;

@end
