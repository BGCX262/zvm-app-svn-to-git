//
//  Team.h
//  ZVM
//
//  Created by Niels Boymanns on 21-09-12.
//  Copyright (c) 2012 kiwi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

@property (nonatomic, copy) NSString *nr, *naam, *plaats, *poule, *resultaten, *doelsaldo, *punten;

-(NSComparisonResult)compareWithAnotherTeam:(Team*)otherTeam;

@end
