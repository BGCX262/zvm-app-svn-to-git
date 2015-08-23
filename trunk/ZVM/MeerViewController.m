//
//  MeerViewController.m
//  ZVM
//
//  Created by Niels Boymanns on 18-10-12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//

#import "MeerViewController.h"
#import "MenuItem.h"

@interface MeerViewController ()

@end

@implementation MeerViewController

@synthesize menuItems;

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
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meerCell"];
    
    if(menuItems.count > 0)
    {
        MenuItem *item = [self.menuItems objectAtIndex:indexPath.row];
    
        cell.textLabel.text = item.naam;
        cell.detailTextLabel.text = item.beschrijving;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            [self performSegueWithIdentifier:@"mapSegue" sender:self];
            break;            
        case 1:
            [self performSegueWithIdentifier:@"teamsSegue" sender:self];
            break;            
        case 2:
            [self performSegueWithIdentifier:@"contactSegue" sender:self];
            break;            
        default:
            break;
    }
}

@end
