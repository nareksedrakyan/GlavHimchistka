//
//  RequestSendMessage.m
//  Glavhimchistka
//
//  Created by Admin on 14.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "RequestSendMessage.h"

@implementation RequestSendMessage
-(instancetype)init
{
    self=[super init];
    if (self)
    {
        [self setId:@""];
        self.mes_type=@"6";
    }
    return self;
}
@end
