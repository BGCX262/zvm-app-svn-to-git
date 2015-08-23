//
//  SpeelschemaViewController.m
//  ZVM
//
//  Created by Niels Boymanns on 12-10-12.
//  Copyright (c) 2012 kiwi. All rights reserved.
//

#import "SpeelschemaViewController.h"
#import "Wedstrijd.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface SpeelschemaViewController ()

@end

@implementation SpeelschemaViewController

@synthesize wedstrijden, speeldata, rij;

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
    
    wedstrijden = [[NSMutableArray alloc] init];
    
    //Format a NSURL containing the location of the webservice
    NSURL *url = [NSURL URLWithString:@"http://api.bc-applications.com/zvm/wedstrijden.json"];
    
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
    speeldata = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < wedstrijden.count; i++)
    {
        if (![speeldata containsObject:[[wedstrijden objectAtIndex:i]datum] ])
        {
            [speeldata addObject:[[wedstrijden objectAtIndex:i]datum]];
        }
    }

    return speeldata.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
 
    int aantal = 0;
    
    for (int i = 0; i < wedstrijden.count; i++)
    {
        if ([[[wedstrijden objectAtIndex:i] datum] isEqualToString:[speeldata objectAtIndex:section]])
        {
            aantal++;
        }
    }
    
    return aantal;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{    
    return [speeldata objectAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"speelschemaCell"];
    Wedstrijd *wedstrijd;
    
    if (rij <= (wedstrijden.count - 1))
    {
        wedstrijd = [self.wedstrijden objectAtIndex:rij];
        
        //Fontysize instellen:
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        
        cell.textLabel.text = wedstrijd.deelnemers;
        cell.detailTextLabel.text = wedstrijd.tijdstip;        
        
        if([wedstrijd.poule isEqualToString:@"A"])
        {
            cell.imageView.image = [UIImage imageNamed:@"Apoule.png"];
        }
        else if([wedstrijd.poule isEqualToString:@"B"])
        {
            cell.imageView.image = [UIImage imageNamed:@"Bpoule.png"];
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"trophy.png"];
        }   
        rij++;
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
            Wedstrijd *wedstrijd;
            
            //Get current date
            NSDate *date = [NSDate date];
            
            for (int i =0; i < [JSON count]; i++)
            {
                
                wedstrijd = [[Wedstrijd alloc] init];
                wedstrijd.datum = [[JSON objectAtIndex:i] objectForKey:@"datum"];
                wedstrijd.tijdstip = [[JSON objectAtIndex:i] objectForKey:@"tijdstip"];
                wedstrijd.deelnemers = [[JSON objectAtIndex:i] objectForKey:@"deelnemers"];
                wedstrijd.ronde = [[JSON objectAtIndex:i] objectForKey:@"ronde"];
                wedstrijd.poule = [[JSON objectAtIndex:i] objectForKey:@"poule"];
                
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"dd-MM-yyyy"];
                
                NSDate *wedstrijdDate = [format dateFromString:wedstrijd.datum];
                if([wedstrijdDate compare:date] == NSOrderedDescending)
                {
                    [wedstrijden addObject:wedstrijd];
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
