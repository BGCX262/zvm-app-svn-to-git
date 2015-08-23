//
//  CompetitieViewController.m
//  ZVM
//
//  Created by Tim on 10/17/12.
//  Copyright (c) 2012 kiwi. All rights reserved.
//

#import "CompetitieViewController.h"
#import "Team.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "StandCell.h"

@interface CompetitieViewController ()
{
    BOOL orientationIsLandscape;
}

@end

@implementation CompetitieViewController

@synthesize teamsPouleA, teamsPouleB;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self){
        // Custom initialization
    }
    return self;
}

-(void)orientationChanged:(NSNotification *)object
{
    //NSLog(@"orientation changed");
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        orientationIsLandscape = false;
        //NSLog(@"Portrait, BOOL orientationIsLandscape: %i", orientationIsLandscape);
        [self.tableView reloadData];
    }
    else if(UIInterfaceOrientationIsLandscape(orientation))
    {
        orientationIsLandscape = true;
        //NSLog(@"Landscape, BOOL orientationIsLandscape %i", orientationIsLandscape);
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    orientationIsLandscape = false;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    teamsPouleA = [[NSMutableArray alloc] init];
    teamsPouleB = [[NSMutableArray alloc] init];
    
    //Format a NSURL containing the location of the webservice
    NSURL *url = [NSURL URLWithString:@"http://api.bc-applications.com/zvm/teams.json"];
    
    //create a request object
    ASIHTTPRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    //Tell the request object that the identifier of this request had ID 100.
    [request setTag:100];
    
    //Tell the request object that de current Viewcontroller wil handle the result.
    [request setDelegate:self];
    
    //Tell the request object to handel the request asynchronous
    [request startAsynchronous];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger result;
    switch (section)
    {
        case 0:
            result = teamsPouleA.count;
            break;
        case 1:
            result = teamsPouleB.count;
            break;
        default:
            result =0;
            break;
    }
    
    return result;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *result;
    switch (section)
    {
        case 0:
            result = (!orientationIsLandscape)
                     ? @"#  Poule A                                       P"
                     : @"#  Poule A                                            G W GL V  DS   P"
            ;
            break;
        case 1:
            result = (!orientationIsLandscape)
                     ? @"#  Poule B                                       P"
                     : @"#  Poule B                                            G W GL V  DS   P"
            ;
            break;
        default:
            result = @"";
            break;
    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    StandCell *cell = (StandCell *)[tableView dequeueReusableCellWithIdentifier:@"competitieCell"];
    
    //Fontsize instellen:
    cell.textLabel.font = [UIFont systemFontOfSize:16];
       
    NSArray *sortedA = [[NSArray alloc]init];
    NSArray *sortedB = [[NSArray alloc]init];
    
    //sorteer de arrays en draai ze om zodat de hoogste vooraan staat ipv achteraan
    sortedA = [[[teamsPouleA sortedArrayUsingSelector:@selector(compareWithAnotherTeam:)] reverseObjectEnumerator] allObjects];
    sortedB = [[[teamsPouleB sortedArrayUsingSelector:@selector(compareWithAnotherTeam:)] reverseObjectEnumerator] allObjects];
    
    Team *teamPouleA = [sortedA objectAtIndex:indexPath.row];
    Team *teamPouleB = [sortedB objectAtIndex:indexPath.row];    
    
    NSString *positie = [NSString stringWithFormat:@"%i", indexPath.row + 1];
    switch (indexPath.section)
    {
        case 0:
            cell.positieLabel.text = positie;
            cell.teamLabel.text = teamPouleA.naam;
            if(orientationIsLandscape)
            {
                cell.resultatenLabel.text = teamPouleA.resultaten;
                cell.doelpuntenLabel.text = teamPouleA.doelsaldo;
            }
            else
            {
                cell.doelpuntenLabel.text = @"";
                cell.resultatenLabel.text = @"";
            }
            cell.puntenLabel.text = teamPouleA.punten;
            break;
        case 1:
            cell.positieLabel.text = positie;
            cell.teamLabel.text = teamPouleB.naam;
            if(orientationIsLandscape)
            {
                cell.resultatenLabel.text = teamPouleB.resultaten;
                cell.doelpuntenLabel.text = teamPouleB.doelsaldo;
            }
            else
            {
                cell.doelpuntenLabel.text = @"";
                cell.resultatenLabel.text = @"";
            }
            cell.puntenLabel.text = teamPouleB.punten;
            break;
        default:
            break;
    }
    
    return cell;
}

- (void) requestFinished:(ASIHTTPRequest *) request
{
    
    if (request.tag == 100)
    {
        NSData *responseData = [request responseData];
        
        NSError *error;
        
        NSArray *JSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        if (!JSON || ![JSON count])
        {
            //do something if there is no data
        }
        else
        {
            //do something with the data
            Team *team;
            
            for (int i =0; i < [JSON count]; i++)
            {
                
                team = [[Team alloc] init];
                team.nr = [[JSON objectAtIndex:i] objectForKey:@"id"];
                team.naam = [[JSON objectAtIndex:i] objectForKey:@"naam"];
                team.plaats = [[JSON objectAtIndex:i] objectForKey:@"plaats"];
                team.poule = [[JSON objectAtIndex:i] objectForKey:@"poule"];
                team.resultaten = [[JSON objectAtIndex:i] objectForKey:@"resultaten"];
                team.doelsaldo = [[JSON objectAtIndex:i] objectForKey:@"doelsaldo"];
                team.punten = [[JSON objectAtIndex:i] objectForKey:@"punten"];
                
                if ([team.poule isEqualToString:@"A"]) {
                    [teamsPouleA addObject:team];
                }
                else if([team.poule isEqualToString:@"B"]){
                    [teamsPouleB addObject:team];
                }                
            }
            
            [self.tableView reloadData];
        }
    }
}

- (void) requestFailed:(ASIHTTPRequest *) request
{
    NSError *error = [request error];
    NSLog(@"Error: %@",error.localizedDescription);
}

@end
