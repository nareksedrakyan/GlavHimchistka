//
//  NSString+findHeightForText.h
//  Glavhimchistka
//
//  Created by Admin on 14.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (findHeightForText)
+(CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;
+(CGSize)findWidthForText:(NSString*)text havingHeight:(CGFloat)heightValue andFont:(UIFont*)font;
@end
