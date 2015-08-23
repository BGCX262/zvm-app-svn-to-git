//
//  SpeelschemaViewController.h
//  ZVM
//
//  Created by Niels Boymanns on 12-10-12.
//  Copyright (c) 2012 kiwi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeelschemaViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *wedstrijden;
@property (nonatomic, strong) NSMutableArray *speeldata;
@property (nonatomic) int rij;

@end
