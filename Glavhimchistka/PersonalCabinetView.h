//
//  PersonalCabinetView.h
//  Glavhimchistka
//
//  Created by Admin on 05.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalCabinetDelegate

-(void)edit;
-(void)sale;
-(void)bonus;

@end

@interface PersonalCabinetView : UIView
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

- (IBAction)editAction:(UIButton *)sender;

- (IBAction)bonusAction:(UIButton *)sender;

- (IBAction)saleAction:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet UIButton *bonusButton;

@property (weak, nonatomic) IBOutlet UIButton *saleButton;



@property(nonatomic,weak)id<PersonalCabinetDelegate>delegate;

@end
