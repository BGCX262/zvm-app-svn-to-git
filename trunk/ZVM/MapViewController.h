//
//  MapViewController.h
//  ZVM
//
//  Created by Niels Boymanns on 18-10-12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<CLLocationManagerDelegate>
{
    IBOutlet MKMapView *mapView;
    CLLocationManager *locationManager;
}

-(void) drawMap;

@end
