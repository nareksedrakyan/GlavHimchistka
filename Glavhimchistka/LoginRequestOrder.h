//
//  LoginRequestOrder.h
// 
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface LoginRequestOrder : JSONModel

@property(strong,nonatomic)NSString*User;
@property(strong,nonatomic)NSString*Password;


@end
