//
//  MapViewController.m
//  Glavhimchistka
//
//  Created by Admin on 28.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#define googleGeocodingAPI @"AIzaSyCK2Gs8BvoWVeoc4S2FGz-tURmfemldJtk"
@interface MapViewController () <GMSMapViewDelegate>
{
    NSString*address;
}
@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) NSMutableArray *positionArray;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    address=[self.addressName copy];
     self.addressName=[self.addressName stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.addressName=[self.addressName stringByReplacingOccurrencesOfString:@"," withString:@",+"];
    
    self.rightMenuButton.hidden=self.isRightMenuButtonHidden;
  
    [self requestGetLocationWithAdress:self.addressName];
    //_positionArray = [[NSMutableArray alloc] init];
    
    
    // Creates a marker in the center of the map.
    
    
    
//    CGPoint point = [self.mapView.projection pointForCoordinate:CLLocationCoordinate2DMake(-33.86, 151.25)];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self createMapView];
//    [self createMarkers:5];
//    
//    [self performSelector:@selector(aaa) withObject:nil afterDelay:6];
//    
//    [self requestGetLocationWithAdress:@"Armenia Erevan"];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return !self.rightMenuButton.hidden;
}

//- (void)aaa {
//    [self focusMap];
//}

- (void)createMapViewWithCoordinate:(CLLocationCoordinate2D) adressCoordinate
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:adressCoordinate.latitude
                                                            longitude:adressCoordinate.longitude
                                                                 zoom:15];
    
    _mapView = [GMSMapView mapWithFrame:CGRectMake(0, 71, self.view.frame.size.width, self.view.frame.size.height-71) camera:camera];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = adressCoordinate;
    marker.title = address;
    marker.map=self.mapView;

    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}

- (void)focusMapToShowAllMarkers:(NSMutableArray *) positionArray {
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    NSMutableArray *markerArray = [[NSMutableArray alloc] init];
    for (CLLocation *location in positionArray) {
        GMSMarker *marker = [GMSMarker markerWithPosition:location.coordinate];
        [markerArray addObject:marker];
    }
    for (GMSMarker *marker in markerArray)
    {
        bounds = [bounds includingCoordinate:marker.position];
    }
    [self.mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:200.f]];
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.mapView.camera.target.latitude longitude:self.mapView.camera.target.longitude zoom:self.mapView.camera.zoom];
//    self.mapView.camera = camera;
    
                                 
                                 
}  



//- (void)focusMap {
//    NSLog(@"position Array = %@",self.positionArray);
//    CGPoint minXpoint = CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
//    CGPoint maxXpoint = CGPointZero;
//    
//    CGPoint p = [self.mapView.projection pointForCoordinate:[(CLLocation *)self.positionArray[0] coordinate]];
//    NSLog(@"******* Point = %@", NSStringFromCGPoint(p));
//    
//    for (int i = 0; i < self.positionArray.count; ++i) {
//        CGPoint currentPoint = [self.mapView.projection pointForCoordinate:[(CLLocation *)self.positionArray[i] coordinate]];
//        if (currentPoint.x > maxXpoint.x) {
//            maxXpoint = currentPoint;
//        }
//        if (currentPoint.x < minXpoint.x) {
//            minXpoint = currentPoint;
//        }
//        
//        NSLog(@"current Point = %@", NSStringFromCGPoint(currentPoint));
//    }
//    
//    NSLog(@"max Point = %@", NSStringFromCGPoint(maxXpoint));
//    NSLog(@"min Point = %@", NSStringFromCGPoint(minXpoint));
//    
//    
//    CGPoint centerPoint = CGPointMake((maxXpoint.x - minXpoint.x) / 2, ABS(maxXpoint.y - minXpoint.y)/2);
//    CLLocationCoordinate2D coordinate = [self.mapView.projection coordinateForPoint:centerPoint];
//    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordinate.latitude longitude:coordinate.longitude zoom:5];
//    self.mapView.camera = camera;
//}


//- (void)createMarkers:(NSUInteger)count {
//    for (int i = 0; i < count; ++i) {
//        GMSMarker *marker = [[GMSMarker alloc] init];
//        marker.position = CLLocationCoordinate2DMake(-33.86 - i, 151.20 + i);
//        marker.title = @"Sydney";
//        marker.snippet = @"Australia";
//        marker.icon = [self image:[UIImage imageNamed:@"mark.png"] scaledToSize:CGSizeMake(45, 75)];
//        marker.map = self.mapView;
//        CLLocation *location = [[CLLocation alloc] initWithLatitude:marker.position.latitude longitude:marker.position.longitude];
//        [self.positionArray addObject:location];
//    }
//}



-(void)requestGetLocationWithAdress:(NSString *)adress
{
    [self.view addSubview:self.loader];
    
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@,&sensor=true&language=ru",adress];
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:nil];
    request.timeoutInterval = 30;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (!data)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self.loader removeFromSuperview];
            return ;
        }
        NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"jsonDtring = %@",jsonString);
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSString *str = [dict valueForKey:@"status"];
        if ([str isEqualToString:@"OK"])
        {
            NSRange latRange;
            latRange.length = 10;
            NSRange range = [jsonString rangeOfString:@"\"lat\" : "];
            latRange.location = range.location + 8;
            NSString *latStriing = [jsonString substringWithRange:latRange];
            NSRange longRange;
            longRange.length = 10;
            range = [jsonString rangeOfString:@"\"lng\" : "];
            latRange.location = range.location + 8;
            NSString *lngStriing = [jsonString substringWithRange:latRange];
            CLLocationCoordinate2D adressCoordinate;
            adressCoordinate.latitude = [latStriing doubleValue];
            adressCoordinate.longitude = [lngStriing doubleValue];
            
            [self createMapViewWithCoordinate:adressCoordinate];
            
            NSLog(@"aaa = %f, %f",adressCoordinate.latitude, adressCoordinate.longitude);
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Your address is not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        [self.loader removeFromSuperview];
        
    }];
}


//- (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size {
//    if (CGSizeEqualToSize(originalImage.size, size)) {
//        return originalImage;
//    }
//    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
//    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
