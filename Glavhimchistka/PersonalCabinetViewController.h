//
//  PersonalCabinetViewController.h
//  Glavhimchistka
//
//  Created by Admin on 04.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "BaseViewController.h"
#import "PersonalCabinetView.h"
#import "EditUserView.h"

@interface PersonalCabinetViewController : BaseViewController<PersonalCabinetDelegate,EditViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UIView *buttonsView;

@end
