//
//  DetailsMapViewController.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>

#import "DetailsMapViewController.h"

@interface DetailsMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation DetailsMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /* map view initialisation */
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    //[self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    // [self.locationManager startUpdatingHeading];
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MKMapTypeHybrid];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    [self.mapView setRotateEnabled: YES];
    [self.mapView setUserInteractionEnabled: YES];
    // [self.mapView setUserTrackingMode: MKUserTrackingModeFollowWithHeading animated: YES];

    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    NSLog(@"%@", [self deviceLocation]);
    
    //View Area
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = 47.4776239 ;
    region.center.longitude =  8.7042655;
    region.span.longitudeDelta = 0.005f;
    region.span.latitudeDelta = 0.005f;
    [self.mapView setRegion:region animated:YES];
    
}

- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
}


@end
