//
//  ResponseToOrder.h
//  Glavhimchistka
//
//  Created by Admin on 15.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface ResponseToOrder : JSONModel
@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@end
