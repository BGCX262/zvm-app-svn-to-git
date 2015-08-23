//
//  Team.m
//  ZVM
//
//  Created by Niels Boymanns on 21-09-12.
//  Copyright (c) 2012 kiwi. All rights reserved.
//

#import "Team.h"

@implementation Team

@synthesize nr, naam, plaats, poule, resultaten, doelsaldo, punten;

-(NSComparisonResult)compareWithAnotherTeam:(Team*)otherTeam
{
    int mpunten = [[self punten] intValue];
    int otherPunten = [[otherTeam punten] intValue];
    
    if (mpunten < otherPunten) return NSOrderedAscending;
    if (mpunten > otherPunten) return NSOrderedDescending;
    return NSOrderedSame;
}

@end
