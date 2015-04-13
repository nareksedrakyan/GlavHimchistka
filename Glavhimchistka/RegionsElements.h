//
//  RegionsElements.h
//  Glavhimchistka
//
//  Created by Admin on 12.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol RegionsElements @end

#import "JSONModel.h"

@interface RegionsElements : JSONModel

@property(nonatomic,strong,getter=getId)NSString*id;
@property(nonatomic,strong)NSString*name;

@end
