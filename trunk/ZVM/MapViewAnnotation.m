//
//  MapViewAnnotation.m
//  ZVM
//
//  Created by Niels Boymanns on 22-10-12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

@synthesize title, subtitle, coordinate;

-(id)initWithTitle:(NSString *) ttl andSubtitle:(NSString *) sttl andCoordinate:(CLLocationCoordinate2D)c2d
{
    self = [super init];
    title = ttl;
    subtitle = sttl;
    coordinate = c2d;
    return self;
}

@end
