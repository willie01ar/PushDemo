//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse setApplicationId:@"kWL15xm2eLdGfXpkTqwNBMqlHHgr2uqVt62MMUGC"
                  clientKey:@"XiLPftZKMBdIktZStHTIEhxl2BWYxAExsf4euZzF"];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    NSDictionary *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (localNotif) {
        NSString *itemName = [localNotif objectForKey:@"aps"];
        [[[UIAlertView alloc] initWithTitle:@"Notif" message:itemName delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    } else {
        NSLog(@"//////////////////////////");
        
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    [application setApplicationIconBadgeNumber:0];
}


@end
