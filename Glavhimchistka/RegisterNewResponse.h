//
//  RegisterNewResponse.h
//  Glavhimchistka
//
//  Created by Admin on 27.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface RegisterNewResponse : JSONModel

@property(nonatomic,strong)NSString*error;
@property(nonatomic,strong)NSString*Msg;
@property(nonatomic,strong)NSString*text;

@end
