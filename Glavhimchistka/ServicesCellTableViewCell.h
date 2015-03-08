//
//  ServicesCellTableViewCell.h
//  Glavhimchistka
//
//  Created by Admin on 07.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITableView *servicesGrupTableView;
@property (weak, nonatomic) IBOutlet UILabel *titLabel;
@property (weak, nonatomic) IBOutlet UIImageView *servicesImageView;
//@property(nonatomic,strong) NSMutableArray*titleGrupArray;
@end
