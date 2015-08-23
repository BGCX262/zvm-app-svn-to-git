//
//  FinaleViewController.h
//  ZVM
//
//  Created by Tim on 10/23/12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wedstrijd.h"

@interface FinaleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *deelnemersLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, strong) Wedstrijd *wedstrijd;

@end
