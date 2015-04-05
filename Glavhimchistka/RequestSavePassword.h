//
//  RequestSavePassword.h
//  Glavhimchistka
//
//  Created by Admin on 06.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface RequestSavePassword : JSONModel
@property(nonatomic,strong)NSString*old;
@property(nonatomic,strong,getter=getNew,setter=setNew:)NSString*new;
@end
