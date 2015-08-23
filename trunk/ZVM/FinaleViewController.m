//
//  FinaleViewController.m
//  ZVM
//
//  Created by Tim on 10/23/12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//

#import "FinaleViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface FinaleViewController ()

@end

@implementation FinaleViewController

@synthesize image, infoLabel, deelnemersLabel, wedstrijd;

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
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    image.image = [UIImage imageNamed:@"soccertrophy.png"];
    deelnemersLabel.text = @"Deelnemers nog niet bekend.";
    infoLabel.text = @"Zodra meer informatie over de finale bekend is wordt deze hier weergegeven.";
    
    if(wedstrijd.deelnemers == @"finale")
    {
        deelnemersLabel.text = wedstrijd.deelnemers;
        
        NSMutableString *info;
        [info appendString:@"Het is zover, op "];
        [info appendString:wedstrijd.datum];
        [info appendString:@" zullen deze teams zich meten met elkaar in een strijd om de beker! Aanvang wedstrijd: "];
        [info appendString:wedstrijd.tijdstip];
        
        infoLabel.text = info;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
