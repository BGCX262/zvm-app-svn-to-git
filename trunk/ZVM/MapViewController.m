//
//  MapViewController.m
//  ZVM
//
//  Created by Niels Boymanns on 18-10-12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//
#define mierlo_lat 51.43731
#define mierlo_lon 5.620095

#import "MapViewController.h"
#import "MapViewAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotateFromInterfaceOrientation:) name:UIDeviceOrientationDidChangeNotification object:nil];   
    
    [self drawMap];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self drawMap];
}

- (void)drawMap
{
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeHybrid;
    
    //Update location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    //Zoom to streetlevel
    CLLocationCoordinate2D zoomlocation;
    zoomlocation.latitude = mierlo_lat;
    zoomlocation.longitude = mierlo_lon;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomlocation, 15000, 15000);
    [mapView setRegion:viewRegion animated:YES];
    
    //Add annotation to mapview
    MapViewAnnotation *destinationAnnotation = [[MapViewAnnotation alloc] initWithTitle:@"Sporthal De Weijer" andSubtitle:@"H. van Scherpenzeelweg 24 - 5731EW Mierlo" andCoordinate:zoomlocation];
    [mapView addAnnotation:destinationAnnotation];
    
    [mapView setShowsUserLocation:YES];
    [self.view addSubview:mapView];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
