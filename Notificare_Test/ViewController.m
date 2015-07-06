//
//  ViewController.m
//  Notificare_Test
//
//  Created by Bruno Tavares on 06/07/15.
//  Copyright (c) 2015 Bruno Tavares. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//const double kMetersPerMile = 1609;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
 
- (void)viewWillAppear:(BOOL)animated {
    
    /*
     * In case we want to use a custom position as default, use this

    CLLocationCoordinate2D zoomLocation;
    
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*kMetersPerMile, 0.5*kMetersPerMile);
    
    [_mapView setRegion:viewRegion animated:YES];
     
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
