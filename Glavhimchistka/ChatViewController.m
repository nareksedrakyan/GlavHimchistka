//
//  ChatViewController.m
//  Glavhimchistka
//
//  Created by Admin on 12.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "CustomView.h"
#import "NSString+findHeightForText.h"
#import "RequestMessageList.h"
#import "ResponseMessageList.h"
#import "ChatViewController.h"
#import "cellUser.h"
#import "cellAdmin.h"
#import "RequestSendMessage.h"
#import "ResponseSendMessage.h"

@interface ChatViewController ()
{
    NSTimer*timer;
    ResponseMessageList*responseMessageListObject;
    NSMutableArray*heightArray;
    BOOL isNewMessage;
    BOOL isFirsCall;
    NSMutableURLRequest* request;
    RequestSendMessage*requestSendMessageObject;
    UITapGestureRecognizer*tgr;
    CustomView*customView;
    CGSize keyboardSize;
    CGSize size;
    RequestMessageList*requestMessageListObject;
    NSInteger oldCount;
}
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     requestMessageListObject=[[RequestMessageList alloc]init];
    if (self.getId==nil )
    {
        [requestMessageListObject setId:@""];
    }
    else
    {
    [requestMessageListObject setId:self.getId];
    }
    self.rightMenuButton.hidden=self.isRightMenuButtonHidden;
    [self registerForKeyboardNotifications];
    
    //Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
    customView=[nib objectAtIndex:0];
    customView.frame=self.scrollView.bounds;
    [self.scrollView addSubview:customView];
    self.scrollView.contentSize=CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    [customView.SendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    customView.chatTextField.delegate=self;
    requestSendMessageObject=[[RequestSendMessage alloc] init];
    
    self.messageTypesTableView=[[UITableView alloc]init];
    self.messageTypesTableView.bounds=CGRectMake(0, 0, 300, 220);
    self.messageTypesTableView.center=self.view.center;
    self.messageTypesTableView.delegate=self;
    self.messageTypesTableView.dataSource=self;
    
    isNewMessage=NO;
    isFirsCall=YES;
    heightArray=[[NSMutableArray alloc] init];
    customView.chatTableView.delegate=self;
    customView.chatTableView.dataSource=self;
    [self requestMessageList];
    timer=[NSTimer scheduledTimerWithTimeInterval:10.f target:self selector:@selector(requestMessageList) userInfo:nil repeats:YES];
    customView.typeOfMessageLabel.userInteractionEnabled=YES;
   
    tgr=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTypesTable)];
    tgr.numberOfTapsRequired=1;
    [customView.typeOfMessageLabel addGestureRecognizer:tgr];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestMessageList
{

   
    
    NSString*jsons=[requestMessageListObject toJSONString];
    
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"%@%@%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/MessageList=",encodeStr,@"&SessionID=",[UserInfo sharedUserInfo].sessionID];
    
    NSURL* url = [NSURL URLWithString:urlString];
    // NSError* error;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
    //                                                       options:NSJSONWritingPrettyPrinted
    //                                                         error:&error];
    request = [NSMutableURLRequest requestWithURL:url];
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
        
        responseMessageListObject = [[ResponseMessageList alloc] initWithString:responseString error:nil];
        isNewMessage=oldCount!=responseMessageListObject.childNode_comments.count;
        oldCount=responseMessageListObject.childNode_comments.count;
        if ([responseMessageListObject.error intValue]==0)
        {
            if (isNewMessage)
            {
                CGSize size_l=[NSString
                               findHeightForText:[responseMessageListObject.childNode_comments.lastObject comment]
                               havingWidth:(self.view.frame.size.width-153)
                               andFont:[UIFont systemFontOfSize:15]];
                [heightArray addObject:[NSNumber numberWithFloat:size_l.height]];
                
                [customView.chatTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
              
                [customView.chatTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            }
        }
        else
        {
            [self showErrorAlertWithMessage:responseMessageListObject.Msg];
        }
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:customView.chatTableView])
    {
        return responseMessageListObject.childNode_comments.count;
    }
    else
    {
        return 5;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([tableView isEqual:customView.chatTableView])
  {
    if([responseMessageListObject.childNode_comments[indexPath.row] user])
    {
        NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
        
        cellUser *cell = (cellUser *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if( cell == nil )
        {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cellUser" owner:self options:nil];
        cell =[nib objectAtIndex:0];
            
        cell.infoView.layer.cornerRadius = 15;
        cell.infoView.layer.borderWidth = 2;
        cell.infoView.layer.borderColor=[UIColor clearColor].CGColor;
        cell.infoView.layer.masksToBounds = YES;
        
        cell.userNameLabel.text=USINFO.userName;
            cell.messageLabel.numberOfLines=0;
        cell.messageLabel.text=[responseMessageListObject.childNode_comments[indexPath.row] comment];
        cell.timeLabel.text=[responseMessageListObject.childNode_comments[indexPath.row] dttm];
        
        }
        cell.userInteractionEnabled=NO;
        [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
    return cell;
    }
      else
      {
          NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
          
          cellAdmin *cell = (cellAdmin *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
          
          if( cell == nil )
          {
              
              NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cellAdmin" owner:self options:nil];
              cell =[nib objectAtIndex:0];
              
              cell.infoView.layer.cornerRadius = 15;
              cell.infoView.layer.borderWidth = 2;
              cell.infoView.layer.borderColor=[UIColor clearColor].CGColor;
              cell.infoView.layer.masksToBounds = YES;
              cell.adminNameLabel.text=@"Главхимчистка";
              cell.messageLabel.numberOfLines=0;
              cell.messageLabel.text=[responseMessageListObject.childNode_comments[indexPath.row] comment];
              cell.timeLabel.text=[responseMessageListObject.childNode_comments[indexPath.row] dttm];
              
          }
          cell.userInteractionEnabled=NO;
          return cell;
      }
    }
    else
    {
        NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if( cell == nil )
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.textLabel.text=@"Отзыв";
                    
                }
                    break;
                case 1:
                {
                    cell.textLabel.text=@"Жалоба";
                }
                    break;
                case 2:
                {
                    cell.textLabel.text=@"Пожелания";
                }
                    break;
                case 3:
                {
                    cell.textLabel.text=@"Некорректные данные";
                }
                    break;
                    
                case 4:
                {
                    cell.textLabel.text=@"Вопрос";
                }
                    break;
            
                default:
                    break;
            }
        }
//        cell.backgroundColor=[UIColor colorWithRed:30.f/255 green:192.f/255 blue:225.f/255 alpha:0.5];
        
        return cell;

    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:customView.chatTableView])
    {
        if (!heightArray.count)
        {
            return 0;
        }
        else
        {
        CGFloat h=([heightArray[indexPath.row] floatValue]+111);
        return h;
        }
    }
    else
    {
        return 44;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.messageTypesTableView])
    {
        switch (indexPath.row)
        {
            case 0:
            {
                requestSendMessageObject.mes_type=@"1";
                
            }
                break;
            case 1:
            {
                requestSendMessageObject.mes_type=@"2";
            }
                break;
            case 2:
            {
                requestSendMessageObject.mes_type=@"3";
            }
                break;
            case 3:
            {
                requestSendMessageObject.mes_type=@"4";
            }
                break;
                
            case 4:
            {
                requestSendMessageObject.mes_type=@"6";
            }
                break;
                
            default:
                break;
        }
        customView.typeOfMessageLabel.text=[[[tableView cellForRowAtIndexPath:indexPath]textLabel]text];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView removeFromSuperview];
    
}

- (void)sendButtonAction
{
    requestSendMessageObject.comment=customView.chatTextField.text;
    requestSendMessageObject.dttm=[self timeWithTimeZone:@"Europe/Moscow"];
    [self requestSendMessage];
}



-(NSString*)timeWithTimeZone:(NSString*)timeZone
{
    NSDate* sourceDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:SS"];
    
    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:timeZone]];
    return [formatter stringFromDate:sourceDate];
}
-(void)showTypesTable
{
    [self.view addSubview:self.messageTypesTableView];
    [self.messageTypesTableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    [self.messageTypesTableView removeFromSuperview];
    customView.SendButton.userInteractionEnabled=NO;
    size=self.scrollView.contentSize;
    NSDictionary* info = [aNotification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.scrollView.contentSize=CGSizeMake(size.width,size.height+keyboardSize.height-self.buttonsView.frame.size.height);
    
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    customView.SendButton.userInteractionEnabled=YES;
    self.scrollView.contentSize=size;
}

-(void)requestSendMessage
{

    
        
        NSString*jsons=[requestSendMessageObject toJSONString];
        
        NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        NSString*urlString=[NSString stringWithFormat:@"%@%@%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/SendMessage=",encodeStr,@"&SessionID=",USINFO.sessionID];
        
        NSURL* url = [NSURL URLWithString:urlString];
        // NSError* error;
        //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
        //                                                       options:NSJSONWritingPrettyPrinted
        //                                                         error:&error];
       NSMutableURLRequest* request1 = [NSMutableURLRequest requestWithURL:url];
        [request1 setURL:url];
        [request1 setHTTPMethod:@"GET"];
        [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request1 setHTTPBody:nil];
        request1.timeoutInterval = 30;
    
    [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data)
        {
            
            
        }
        NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString*responseString=[[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        
        NSLog(@"responseString:%@",responseString);
       ResponseSendMessage* responseSendMessageObject = [[ResponseSendMessage alloc] initWithString:responseString error:nil];
        if (responseSendMessageObject && [responseSendMessageObject.error intValue]==0)
        {
            if (isFirsCall)
            {
                isFirsCall=NO;
                [requestSendMessageObject setId:responseSendMessageObject.getId];
                [requestMessageListObject setId:responseSendMessageObject.getId];
                [self requestSendMessage];
            }
            else
            {
                customView.chatTextField.text=@"";
                [self requestMessageList];
                
            }
           //[customView.chatTableView reloadData];
        }
        else if(responseSendMessageObject.Msg)
        {
            [self showErrorAlertWithMessage:responseSendMessageObject.Msg];
        }
       
    }];
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
