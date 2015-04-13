//
//  ResponseGetRegions.h
//  Glavhimchistka
//
//  Created by Admin on 12.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "RegionsElements.h"
#import "JSONModel.h"

@interface ResponseGetRegions : JSONModel
@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@property(nonatomic,strong)NSMutableArray<RegionsElements>*regions;
@end
