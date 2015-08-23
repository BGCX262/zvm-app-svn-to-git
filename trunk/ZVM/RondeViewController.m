//
//  Ronde1ViewController.m
//  ZVM
//
//  Created by Tim on 10/23/12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//

#import "RondeViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Wedstrijd.h"
#import "UitslagenCell.h"

@interface RondeViewController ()

@end

@implementation RondeViewController

@synthesize wedstrijden;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        
    self.title = @"Uitslagen";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return ([self.wedstrijden count] == 0) ? 1 : [self.wedstrijden count];
    //return [self.wedstrijden count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UitslagenCell *cell = (UitslagenCell *)[tableView dequeueReusableCellWithIdentifier:@"rondeCell"];
    
    if(wedstrijden.count > 0)
    {
        Wedstrijd *wedstrijd = [self.wedstrijden objectAtIndex:indexPath.row];
        cell.wedstrijdLabel.text = wedstrijd.deelnemers;
        cell.uitslagLabel.text = wedstrijd.uitslag;
    }
    else
    {
        cell.wedstrijdLabel.text = @"Er is nog geen informatie beschikbaar.";
        cell.uitslagLabel.text = @"";
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(wedstrijden.count > 0)
    {
        switch ([[[wedstrijden objectAtIndex:0] ronde] intValue])
        {
            case 1:
                return @"Uitslagen ronde 1";
                break;
            case 2:
                return @"Uitslagen ronde 2";
                break;
            case 3:
                return @"Uitslagen ronde 3";
                break;
            default:
                break;
        }
    }
    return @"Uitslagen";
}

@end
