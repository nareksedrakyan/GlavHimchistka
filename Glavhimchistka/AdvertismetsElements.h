//
//  AdvertismetsElements.h
//  Glavhimchistka
//
//  Created by Admin on 11.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol  AdvertismetsElements @end

#import "JSONModel.h"
#import "ImagesElements.h"

@interface AdvertismetsElements : JSONModel
@property(nonatomic,strong)NSMutableArray<ImagesElements>*img;
@property(nonatomic,strong,getter=getId)NSString*id;
@property(nonatomic,strong)NSString*type;
@end
