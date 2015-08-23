//
//  ContactViewController.m
//  ZVM
//
//  Created by Tim on 10/22/12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

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
    self.view.backgroundColor = [UIColor darkGrayColor];
        
    //image
    contactImage.image = [UIImage imageNamed:@"sporthal.png"];
    
    //label
    contactLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 0.0f, scrollview.contentSize.width, scrollview.contentSize.height)];
    contactLabel.backgroundColor = [UIColor darkGrayColor];
    contactLabel.textColor = [UIColor lightGrayColor];
    contactLabel.font = [UIFont fontWithName:@"Avenir Next Condensed-Bold" size:17];
    contactLabel.text = @"Adres sporthal:\nHeer van Scherpenzeelweg 24\n5731EW Mierlo\n\nSecretaris:\nEdwin van Elven\nNieuwHuis 18\n5731MT Mierlo\n0492-665361\ne.vanelven@planet.nl\n\nLedenadministratie:\nRoland van de Mosselaar\nTarwe 37\n5731LD Mierlo\n 0651385471\n\n";
    contactLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contactLabel.numberOfLines = 0;    
    [contactLabel sizeToFit];
    
    //scrollview 
    [scrollview addSubview:contactLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
