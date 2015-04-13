//
//  DepartureView.h
//  Glavhimchistka
//
//  Created by Admin on 12.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol DepartureViewDelegate

-(void)actionSwitch:(BOOL)isOn;
-(void)actionToOrder;
-(void)actionChooseTime;
-(void)actionChooseDate;
-(void)actionChooseRegion;

@end


#import <UIKit/UIKit.h>

@interface DepartureView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightSwitchLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightSwitch;
- (IBAction)actionChooseTime:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *chooseTimeButton;
- (IBAction)actionChooseDate:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *chooseDateButton;
- (IBAction)actionChooseRegion:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *chooseRegionButton;
- (IBAction)toOrderAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *toOrderButton;
- (IBAction)mySwitchAction:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel;



@property(nonatomic,weak)id<DepartureViewDelegate>delegate;

@end
