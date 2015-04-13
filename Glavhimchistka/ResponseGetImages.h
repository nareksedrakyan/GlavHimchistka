//
//  ResponseGetImages.h
//  Glavhimchistka
//
//  Created by Admin on 11.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "AdvertismetsElements.h"
#import "JSONModel.h"

@interface ResponseGetImages : JSONModel
@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@property(nonatomic,strong)NSMutableArray<AdvertismetsElements>*advertisments;
@end
