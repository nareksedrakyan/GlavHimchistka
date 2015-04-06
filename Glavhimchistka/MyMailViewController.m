//
//  MyMailViewController.m
//  Glavhimchistka
//
//  Created by Admin on 04.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "ResponseTitleMessages.h"
#import "MyMailViewController.h"
#import "MailCell.h"
#import "ChatViewController.h"

@interface MyMailViewController ()
{
    ResponseTitleMessages*responseTitleMessagesObject;
}
@end

@implementation MyMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightMenuButton.hidden=self.isRightMenuButtonHidden;
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self requestGetTitleMessages];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestGetTitleMessages
{
    [self.view addSubview:self.loader];
    
    //    RequestPriceList*requestPriceListObject=[[RequestPriceList alloc]init];
    //
    //    NSString*jsons=[requestPriceListObject toJSONString];
    //
    //    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSString*urlString=[NSString stringWithFormat:@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/TitleMessages&SessionID=%@",USINFO.sessionID];
    NSURL* url = [NSURL URLWithString:urlString];
    // NSError* error;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
    //                                                       options:NSJSONWritingPrettyPrinted
    //                                                         error:&error];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:nil];
    request.timeoutInterval = 30;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data)
        {
            
            
        }
        NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString*responseString=[[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        
        NSLog(@"responseString:%@",responseString);
        responseTitleMessagesObject = [[ResponseTitleMessages alloc] initWithString:responseString error:nil];
        [self.loader removeFromSuperview];
        
        if (responseTitleMessagesObject&&[responseTitleMessagesObject.error intValue]==0)
        {
            self.mailTableView.delegate=self;
            self.mailTableView.dataSource=self;
            [self.mailTableView reloadData];
        }
        else if (responseTitleMessagesObject.Msg)
        {
            [self showErrorAlertWithMessage:responseTitleMessagesObject.Msg];
        }
    }];
    
}

#pragma mark-tableView metods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return responseTitleMessagesObject.Messages.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
    
    MailCell *cell = (MailCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if( cell == nil )
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MailCell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
        
        cell.commentLabel.text=[responseTitleMessagesObject.Messages[indexPath.row] comment];
       
        cell.dateLabel.text=[responseTitleMessagesObject.Messages[indexPath.row] dttm];
        
        if ([[responseTitleMessagesObject.Messages[indexPath.row] getNew_mes_count] intValue])
        {
            cell.countLabelWidth.constant=20;
            
            cell.countLabel.layer.cornerRadius = 15;
            cell.countLabel.layer.borderWidth = 2;
            cell.countLabel.layer.borderColor=[UIColor clearColor].CGColor;
            cell.countLabel.layer.masksToBounds = YES;
           
            cell.countLabel.text=[responseTitleMessagesObject.Messages[indexPath.row] getNew_mes_count];

        }
        else
        {
            cell.countLabelWidth.constant=0;
        }
    
        switch ([[responseTitleMessagesObject.Messages[indexPath.row] message_type] intValue])
        {
            case 1:
            {
                cell.userImageView.image=[UIImage imageNamed:@"otziv.png"];//Отзыв
                
            }
                break;
            case 2:
            {
                cell.userImageView.image=[UIImage imageNamed:@"jaloba.png"];//Жалоба
            }
                break;
            case 3:
            {
                cell.userImageView.image=[UIImage imageNamed:@"pojelania.png"];//Пожелания
            }
                break;
            case 4:
            {
                cell.userImageView.image=[UIImage imageNamed:@"nekorektnie_dannie.png"];//Некорректные данные
            }
                break;
                
            case 5:
            {
                cell.userImageView.image=[UIImage imageNamed:@"vopros.png"];//Вопрос
            }
                break;
                
            default:
                break;
        }
        
        
        // [cell  setValue:simpleTableIdentifier forKey:@"reuseIdentifier"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 71;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController*cvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
    [cvc setTitleId:[responseTitleMessagesObject.Messages[indexPath.row] getId]];
    cvc.message_type=[responseTitleMessagesObject.Messages[indexPath.row] message_type];
    [self.navigationController pushViewController:cvc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return !self.rightMenuButton.hidden;
}


@end
