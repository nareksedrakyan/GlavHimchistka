//
//  AddressListElements.h
//  Glavhimchistka
//
//  Created by Admin on 14.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol AddressListElements @end
#import "JSONModel.h"

@interface AddressListElements : JSONModel
@property(strong,nonatomic,getter=getId)NSString*id;
@property(strong,nonatomic)NSString*name;
@end
