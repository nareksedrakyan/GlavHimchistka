//
//  ChatViewController.m
//  Glavhimchistka
//
//  Created by Admin on 12.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//


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
}
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chatTextField.delegate=self;
    requestSendMessageObject=[[RequestSendMessage alloc] init];
    
    self.messageTypesTableView=[[UITableView alloc]init];
    self.messageTypesTableView.bounds=CGRectMake(0, 0, 300, 220);
    self.messageTypesTableView.center=self.view.center;
    self.messageTypesTableView.delegate=self;
    self.messageTypesTableView.dataSource=self;
    
    isNewMessage=NO;
    isFirsCall=YES;
    heightArray=[[NSMutableArray alloc] init];
    self.chatTableView.delegate=self;
    self.chatTableView.dataSource=self;
    [self requestMessageList];
    timer=[NSTimer scheduledTimerWithTimeInterval:10.f target:self selector:@selector(requestMessageList) userInfo:nil repeats:YES];
//    self.typeOfMessageTextField.userInteractionEnabled=YES;
//    tgr=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTypesTable)];
//    tgr.numberOfTapsRequired=1;
//    [self.typeOfMessageTextField addGestureRecognizer:tgr];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestMessageList
{
    if (isFirsCall)
    {
    RequestMessageList*requestMessageListObject=[[RequestMessageList alloc]init];
    
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
    isFirsCall=NO;
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data)
        {
           
            
        }
        NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString*responseString=[[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        
        NSLog(@"responseString:%@",responseString);
        responseMessageListObject = [[ResponseMessageList alloc] initWithString:responseString error:nil];
        if ([responseMessageListObject.error intValue]==0)
        {
            for (int i=0; i<responseMessageListObject.childNode_comments.count; i++)
            {
                if (!isNewMessage)
                {
                  if  (![responseMessageListObject.childNode_comments[i] status_message])
                  {
                      isNewMessage=YES;
                  }
                }
                CGSize size=[NSString
                             findHeightForText:[responseMessageListObject.childNode_comments[i] comment]
                 havingWidth:(self.view.frame.size.width-153)
                             andFont:[UIFont systemFontOfSize:15]];
                [heightArray addObject:[NSNumber numberWithFloat:size.height]];
            }
            if (isNewMessage)
            {
                [self.chatTableView reloadData];
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
    if ([tableView isEqual:self.chatTableView])
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
    if ([tableView isEqual:self.chatTableView])
  {
    if([responseMessageListObject.childNode_comments[indexPath.row] user])
    {
        NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
        
        cellUser *cell = (cellUser *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if( cell == nil )
        {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cellUser" owner:self options:nil];
        cell =[nib objectAtIndex:0];
            
        cell.infoView.layer.cornerRadius = 30;
        cell.infoView.layer.borderWidth = 2;
        cell.infoView.layer.borderColor=[UIColor clearColor].CGColor;
        cell.infoView.layer.masksToBounds = YES;
        
        cell.userNameLabel.text=USINFO.userName;
        cell.messageLabel.text=[responseMessageListObject.childNode_comments[indexPath.row] comment];
        cell.timeLabel.text=[responseMessageListObject.childNode_comments[indexPath.row] dttm];
        
        }
        cell.userInteractionEnabled=NO;
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
              
              cell.infoView.layer.cornerRadius = 30;
              cell.infoView.layer.borderWidth = 2;
              cell.infoView.layer.borderColor=[UIColor clearColor].CGColor;
              cell.infoView.layer.masksToBounds = YES;
              cell.adminNameLabel.text=@"Главхимчистка";
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
    if ([tableView isEqual:self.chatTableView])
    {
        return  [heightArray[indexPath.row] floatValue];
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
        self.typeOfMessageTextField.placeholder=[[[tableView cellForRowAtIndexPath:indexPath]textLabel]text];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView removeFromSuperview];
    
}

- (IBAction)sendButtonAction:(UIButton *)sender
{
    requestSendMessageObject.comment=self.chatTextField.text;
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.typeOfMessageTextField];
    
    //Checks if the tap was inside the textview bounds
    if (CGRectContainsPoint(self.typeOfMessageTextField.bounds, location))
    {
        [self showTypesTable];
    }
}
@end
