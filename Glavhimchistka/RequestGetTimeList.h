//
//  RequestGetTimeList.h
//  Glavhimchistka
//
//  Created by Admin on 15.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface RequestGetTimeList : JSONModel
@property(nonatomic,strong)NSString*date;
@property(nonatomic,strong,getter=getId,setter=setID:)NSString*id;
@end
