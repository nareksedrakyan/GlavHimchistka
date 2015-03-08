//
//  ResponsePriceList.h
//  Glavhimchistka
//
//  Created by Admin on 07.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"
#import "PriceElements.h"
@interface ResponsePriceList : JSONModel

@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@property(strong,nonatomic)NSMutableArray<PriceElements>*price_list;
@end
