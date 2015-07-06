//
//  AppDelegate.h
//  Notificare_Test
//
//  Created by Bruno Tavares on 06/07/15.
//  Copyright (c) 2015 Bruno Tavares. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NotificarePushLib.h"
#import "Notificare.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NotificarePushLibDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

