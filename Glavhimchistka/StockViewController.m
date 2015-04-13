//
//  StockViewController.m
//  Glavhimchistka
//
//  Created by Admin on 11.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "StockViewController.h"
#import "RequestGetImages.h"
#import "ResponseGetImages.h"

@interface StockViewController ()
{
    ResponseGetImages*responseGetImagesObject;
    CGFloat w;
    CGFloat h;
    CGFloat height;
}
@end

@implementation StockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestGetImages];
    height=0;
    w=self.view.frame.size.width;
    
    self.rightMenuButton.hidden=self.isRightMenuButtonHidden;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestGetImages
{
    [self.view addSubview:self.loader];
    RequestGetImages*requestGetImagesObject=[[RequestGetImages alloc]init];
    
    NSString*jsons=[requestGetImagesObject toJSONString];
    
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/Advertisment=%@",encodeStr];
    
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
        NSString*responseString=jsonString;
//        [[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        
        NSLog(@"responseString:%@",responseString);
        
        responseGetImagesObject = [[ResponseGetImages alloc] initWithString:responseString error:nil];
        
        if (responseGetImagesObject && [responseGetImagesObject.error intValue]==0)
        {
            [self fillScrollView];
        }
        else
        {
            [self showErrorAlertWithMessage:responseGetImagesObject.Msg];
        }
        [self.loader removeFromSuperview];
    }];

}

-(void)fillScrollView
{
    for (int i=0; i<responseGetImagesObject.advertisments.count; i++)
    {
        for (int j=0; j<[[responseGetImagesObject.advertisments[i]img]count]; j++)
        {
            UIImage*image=[self decodeBase64ToImage:[[[responseGetImagesObject.advertisments[i]img]objectAtIndex:j]img64]];
            h=image.size.height*w/image.size.width;
            UIImageView*imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, height, w, h)];
            height=height+h;
            imageView.image=image;
            [self.scrollView addSubview:imageView];
            self.scrollView.contentSize=CGSizeMake(w, height);
            
            
        }
    }
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
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
