//
//  TripsElements.h
//  Glavhimchistka
//
//  Created by Admin on 15.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol TripsElements @end

#import "JSONModel.h"

@interface TripsElements : JSONModel

@property(nonatomic,strong,getter=getHour)NSString*hour;
@property(nonatomic,strong)NSString*engaged;

@end
