//
//  BaseViewController.m
//  Glavhimchistka
//
//  Created by Admin on 20.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "UIImage+animatedGIF.h"
#import "BaseViewController.h"

@interface BaseViewController ()
{
    NSMutableArray*titleArray;
    NSMutableArray*imageArray;
    NSString*urlString;
    NSString* authLink;
}
@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    urlString=@"https://itunes.apple.com/us/app/glavhimchistka/id986310493?ls=1&mt=8";
    
    NSURL*url = [[NSBundle mainBundle] URLForResource:@"loader" withExtension:@"gif"];
    self.loader=[[UIImageView alloc] init];
    self.loader.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    self.loader.bounds=CGRectMake(0, 0,30,30);
    self.loader.center=self.view.center;
    [self.facebookButton setBackgroundImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateHighlighted];
    [self.twitterButton setBackgroundImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateHighlighted];
    [self.googlePlusButton setBackgroundImage:[UIImage imageNamed:@"google_plus.png"] forState:UIControlStateHighlighted];
    [self.instagramButton setBackgroundImage:[UIImage imageNamed:@"instagram.png"] forState:UIControlStateHighlighted];
    [self.vkButton setBackgroundImage:[UIImage imageNamed:@"vkontakte_on_select.png"] forState:UIControlStateHighlighted];
   
    self.rootTableView.delegate=self;
    self.rootTableView.dataSource=self;
    self.rootTableView.scrollEnabled=NO;
    self.rootTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if (self.rootTableView.tag==100)
    {
        titleArray=[NSMutableArray arrayWithObjects:@"Задать вопрос",@"Контакты",@"Заказать выезд",@"Акции",@"Услуги", nil];
        imageArray=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"question.png"],[UIImage imageNamed:@"map.png"],[UIImage imageNamed:@"delivery.png"],[UIImage imageNamed:@"sale.png"],[UIImage imageNamed:@"services_list.png"], nil];
    }
    else if (self.rootTableView.tag==101)
    {
        titleArray=[NSMutableArray arrayWithObjects:@"Вход",@"Задать вопрос",@"Контакты",@"Заказать выезд",@"Акции",@"Услуги", nil];
        imageArray=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"user_login.png"],[UIImage imageNamed:@"question.png"],[UIImage imageNamed:@"map.png"],[UIImage imageNamed:@"delivery.png"],[UIImage imageNamed:@"sale.png"],[UIImage imageNamed:@"services_list.png"], nil];
    }
   
    [self.rightMenuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
   [self.leftMenuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%@",USINFO.sessionID);
    if (USINFO.sessionID)
    {
        self.isRightMenuButtonHidden=NO;
    }
    else
    {
        self.isRightMenuButtonHidden=YES;
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
    
    RootTableViewCell *cell = (RootTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if( cell == nil )
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RootTableViewCell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
       
        cell.backgroundColor=[UIColor colorWithRed:0.f/255 green:172.f/255 blue:242.f/255 alpha:1];
        
        //        [cell  setValue:simpleTableIdentifier forKey:@"reuseIdentifier"];
        cell.cellTextLabel.text=titleArray[indexPath.row];
        cell.cellImageView.image=imageArray[indexPath.row];
        
        
        
    }
    UIView *selectedView = [[UIView alloc]initWithFrame:cell.frame];
    selectedView.backgroundColor = [UIColor colorWithRed:3.f/255 green:92.f/255 blue:125.f/255 alpha:1];
    cell.selectedBackgroundView =  selectedView;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  57;
}


- (IBAction)actionVK:(UIButton *)sender
{
    authLink = [NSString stringWithFormat:@"http://vkontakte.ru/share.php?url=%@",urlString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authLink]];
}

- (IBAction)actionInstagram:(UIButton *)sender
{
   authLink=@"https://instagram.com/glavhimchistka/";
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authLink]];
}

- (IBAction)actionTwitter:(UIButton *)sender
{
    authLink = [NSString stringWithFormat:@"http://twitter.com/intent/tweet?source=sharethiscom&url=%@", urlString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authLink]];
}

- (IBAction)actionGooglePlus:(UIButton *)sender
{
    authLink = [NSString stringWithFormat:@"https://plus.google.com/share?url=%@", urlString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authLink]];
}

- (IBAction)actionFacebook:(UIButton *)sender
{
     authLink = [NSString stringWithFormat:@"https://m.facebook.com/sharer.php?u=%@&t=Message", urlString];
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authLink]];
}


// authLink=[authLink stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];


-(void)showErrorAlertWithMessage:(NSString*)messageText
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@ "" message:messageText preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction*cancel = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * action)
                            {
                                [alert dismissViewControllerAnimated:YES completion:nil];
                            }];
    
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
