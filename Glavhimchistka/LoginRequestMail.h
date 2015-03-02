//
//  LoginRequestMail.h
//  Glavhimchistka
//
//  Created by Admin on 01.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface LoginRequestMail : JSONModel
@property(strong,nonatomic)NSString*LoginMail;
@property(strong,nonatomic)NSString*Password;
@end
