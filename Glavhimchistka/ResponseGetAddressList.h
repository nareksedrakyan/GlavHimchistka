//
//  ResponseGetAddressList.h
//  Glavhimchistka
//
//  Created by Admin on 14.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "AddressListElements.h"
#import "JSONModel.h"

@interface ResponseGetAddressList : JSONModel
@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@property(strong,nonatomic)NSMutableArray<AddressListElements>*address_contr;

@end
