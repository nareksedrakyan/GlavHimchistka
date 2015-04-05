//
//  ResponseGetDeposit.h
//  Glavhimchistka
//
//  Created by Admin on 05.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface ResponseGetDeposit : JSONModel

@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;

@property(nonatomic,strong)NSString*deposit_rest;

@end
