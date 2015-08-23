//
//  UitslagenViewController.m
//  ZVM
//
//  Created by Tim on 10/17/12.
//  Copyright (c) 2012 kiwi. All rights reserved.
//

#import "UitslagenViewController.h"
#import "Wedstrijd.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "UitslagenCell.h"

@interface UitslagenViewController ()

@end

@implementation UitslagenViewController

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
    UitslagenCell *cell = (UitslagenCell *)[tableView dequeueReusableCellWithIdentifier:@"UitslagenCell"];
    
    if (rij <= (wedstrijden.count - 1))
    {
        Wedstrijd *wedstrijd = [self.wedstrijden objectAtIndex:rij];
       
        cell.wedstrijdLabel.text = (wedstrijd) ? wedstrijd.deelnemers : @"";
        cell.uitslagLabel.text = (wedstrijd) ? wedstrijd.uitslag : @"";
        
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
                wedstrijd.uitslag = [[JSON objectAtIndex:i] objectForKey:@"uitslag"];
                wedstrijd.deelnemers = [[JSON objectAtIndex:i] objectForKey:@"deelnemers"];
                wedstrijd.ronde = [[JSON objectAtIndex:i] objectForKey:@"ronde"];
                wedstrijd.poule = [[JSON objectAtIndex:i] objectForKey:@"poule"];
                
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"dd-MM-yyyy"];
                
                NSDate *wedstrijdDate = [format dateFromString:wedstrijd.datum];
                if([wedstrijdDate compare:date] == NSOrderedAscending && [wedstrijd.ronde isEqualToString:@""])
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
