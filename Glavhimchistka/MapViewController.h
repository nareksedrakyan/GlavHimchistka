//
//  MapViewController.h
//  Glavhimchistka
//
//  Created by Admin on 28.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "BaseViewController.h"
#import <UIKit/UIKit.h>

@interface MapViewController :BaseViewController
@property (weak, nonatomic) IBOutlet UIView *buttonsView;

@property(nonatomic,strong)NSString*addressName;

@end
