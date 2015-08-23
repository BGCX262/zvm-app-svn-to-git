//
//  BekerViewController.m
//  ZVM
//
//  Created by Tim on 10/23/12.
//  Copyright (c) 2012 Niels Boymanns. All rights reserved.
//

#import "BekerViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Wedstrijd.h"
#import "RondeViewController.h"
#import "FinaleViewController.h"

@interface BekerViewController ()

@end

@implementation BekerViewController

@synthesize btnRonde1, btnFinale, btnRonde2, btnRonde3, wedstrijdenRonde1, wedstrijdenRonde2, wedstrijdenRonde3, finale;

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
    btnRonde1.layer.cornerRadius = 8.0f;
    btnRonde2.layer.cornerRadius = 8.0f;
    btnRonde3.layer.cornerRadius = 8.0f;
    btnFinale.layer.cornerRadius = 8.0f;
    
    wedstrijdenRonde1 = [[NSMutableArray alloc] init];
    wedstrijdenRonde2 = [[NSMutableArray alloc] init];
    wedstrijdenRonde3 = [[NSMutableArray alloc] init];
    
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

-(NSString *) convertDateFromDigitsToMonth: (NSString*) digits
{
    switch([digits intValue])
    {
        case 1: return @" jan"; break;            
        case 2: return @" feb"; break;
        case 3: return @" mrt"; break;
        case 4: return @" apr"; break;
        case 5: return @" mei"; break;
        case 6: return @" jun"; break;
        case 7: return @" jul"; break;
        case 8: return @" aug"; break;
        case 9: return @" sep"; break;
        case 10: return @" okt"; break;
        case 11: return @" nov"; break;
        case 12: return @" dec"; break;
        default: break;
    }
    return @"";
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
            
            for (int i =0; i < [JSON count]; i++)
            {
                wedstrijd = [[Wedstrijd alloc] init];
                wedstrijd.datum = [[JSON objectAtIndex:i] objectForKey:@"datum"];
                wedstrijd.tijdstip = [[JSON objectAtIndex:i] objectForKey:@"tijdstip"];
                wedstrijd.deelnemers = [[JSON objectAtIndex:i] objectForKey:@"deelnemers"];
                wedstrijd.ronde = [[JSON objectAtIndex:i] objectForKey:@"ronde"];
                wedstrijd.poule = [[JSON objectAtIndex:i] objectForKey:@"poule"];
                wedstrijd.uitslag = [[JSON objectAtIndex:i] objectForKey:@"uitslag"];
                
                if([wedstrijd.uitslag isEqualToString:@""])
                {
                    NSMutableString *datum = [[NSMutableString alloc] init];
                    [datum appendString:[wedstrijd.datum substringWithRange:NSMakeRange(0, 2)]];                   
                    NSString *maand = [wedstrijd.datum substringWithRange:NSMakeRange(3, 2)];
                    [datum appendString:[self convertDateFromDigitsToMonth:maand]];
                    
                    wedstrijd.uitslag = datum;
                }
                
                if([wedstrijd.ronde isEqualToString:@"finale"])
                {
                    finale = wedstrijd;
                }
                else
                {
                    switch ([wedstrijd.ronde intValue])
                    {
                        case 1:
                            [wedstrijdenRonde1 addObject:wedstrijd];
                            break;
                        case 2:
                            [wedstrijdenRonde2 addObject:wedstrijd];
                            break;
                        case 3:
                            [wedstrijdenRonde3 addObject:wedstrijd];
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }
}

- (void) requestFailed:(ASIHTTPRequest *) request
{
    NSError *error = [request error];
    NSLog(@"Error: %@",error.localizedDescription);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"ronde1Segue"])
    {
        RondeViewController *rvc = segue.destinationViewController;
        rvc.wedstrijden = wedstrijdenRonde1;
    }
    else if([[segue identifier] isEqualToString:@"ronde2Segue"])
    {
        RondeViewController *rvc = segue.destinationViewController;
        rvc.wedstrijden = wedstrijdenRonde2;
    }
    else if([[segue identifier] isEqualToString:@"ronde3Segue"])
    {
        RondeViewController *rvc = segue.destinationViewController;
        rvc.wedstrijden = wedstrijdenRonde3;
    }
    else if([[segue identifier] isEqualToString:@"finaleSegue"])
    {
        FinaleViewController *fvc = segue.destinationViewController;
        fvc.wedstrijd = finale;
    }
}

@end
