//
//  ResponseSavePassword.h
//  Glavhimchistka
//
//  Created by Admin on 06.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface ResponseSavePassword : JSONModel
@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@end
