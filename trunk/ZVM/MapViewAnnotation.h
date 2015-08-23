//
//  MapViewAnnotation.h
//  ZVM
//
//  Created by Niels Boymanns on 22-10-12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapViewAnnotation : NSObject<MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id)initWithTitle:(NSString *) ttl andSubtitle:(NSString *) sttl andCoordinate:(CLLocationCoordinate2D)c2d;

@end
