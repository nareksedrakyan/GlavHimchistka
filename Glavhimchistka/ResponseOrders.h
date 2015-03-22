//
//  ResponseOrders.h
//  Glavhimchistka
//
//  Created by Admin on 21.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "OrdersElements.h"
#import "JSONModel.h"

@interface ResponseOrders : JSONModel

@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@property(strong,nonatomic)NSMutableArray<OrdersElements>*orders;

@end
