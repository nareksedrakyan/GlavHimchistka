//
//  ImagesElements.h
//  Glavhimchistka
//
//  Created by Admin on 11.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol ImagesElements @end
#import "JSONModel.h"

@interface ImagesElements : JSONModel

@property(nonatomic,strong)NSString*adv_id;
@property(nonatomic,strong)NSString*path;
@property(nonatomic,strong)NSString*img64;

@end
