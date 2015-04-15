//
//  ResponseGetTimeList.h
//  Glavhimchistka
//
//  Created by Admin on 15.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "TripsElements.h"
#import "JSONModel.h"

@interface ResponseGetTimeList : JSONModel
@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@property(strong,nonatomic)NSMutableArray<TripsElements>*trips;
@end
