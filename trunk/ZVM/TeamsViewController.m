//
//  TeamsViewController.m
//  ZVM
//
//  Created by Niels Boymanns on 21-09-12.
//  Copyright (c) 2012 kiwi. All rights reserved.
//

#import "TeamsViewController.h"
#import "Team.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface TeamsViewController ()

@end

@implementation TeamsViewController

@synthesize teamsPouleA, teamsPouleB;

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
            result = @"Poule A";
            break;
        case 1:
            result = @"Poule B";
            break;
        default:
            result = @"";
            break;
    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teamsCell"];
    Team *teamPouleA = [self.teamsPouleA objectAtIndex:indexPath.row];
    Team *teamPouleB = [self.teamsPouleB objectAtIndex:indexPath.row];
    
    //Fontysize instellen:
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    switch (indexPath.section)
    {
        case 0:
            cell.textLabel.text = teamPouleA.naam;
            cell.detailTextLabel.text = teamPouleA.plaats;
            break;
        case 1:
            cell.textLabel.text = teamPouleB.naam;
            cell.detailTextLabel.text = teamPouleB.plaats;
            break;
        default:
            cell.textLabel.text = @"";
            cell.detailTextLabel.text = @"";
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
