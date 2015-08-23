//
//  BekerViewController.h
//  ZVM
//
//  Created by Tim on 10/23/12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Wedstrijd.h"

@interface BekerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnRonde1;
@property (weak, nonatomic) IBOutlet UIButton *btnRonde2;
@property (weak, nonatomic) IBOutlet UIButton *btnRonde3;
@property (weak, nonatomic) IBOutlet UIButton *btnFinale;

@property (nonatomic, strong) NSMutableArray *wedstrijdenRonde1, *wedstrijdenRonde2, *wedstrijdenRonde3;
@property (nonatomic, copy) Wedstrijd *finale;

-(NSString *) convertDateFromDigitsToMonth: (NSString*) digits;

@end
