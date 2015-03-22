//
//  RequestOrdersHistory.m
//  Glavhimchistka
//
//  Created by Admin on 21.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "RequestOrdersHistory.h"

@implementation RequestOrdersHistory
-(instancetype)init
{
    self=[super init];
    if (self)
    {
        self.mon=@"2";
        self.sclad=@"1";
    }
    return self;
}
@end
