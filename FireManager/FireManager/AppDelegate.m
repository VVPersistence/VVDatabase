//
//  AppDelegate.m
//  FireManager
//
//  Created by laouhn on 15/10/27.
//  Copyright (c) 2015年 weiwei. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
     沙盒文件夹中的几个文件夹的作用：
     Documents：存储持久保存的数据。
     Library：caches文件夹用来存储缓存文件比如缓存的音频，视频，图片等，preference：存放偏好设置信息比如使用NSUserDefaults存储的数据。
     tem：存放临时的数据比如下载的zip文件。
    */
//    获取沙盒文件夹的路经
    NSString *filePath = NSHomeDirectory();
//    NSLog(@"%@", filePath);
    //偏好设置
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(YES) forKey:@"haveLogin"];
    [userDefaults setObject:@"1551336573" forKey:@"Account"];
    [userDefaults setObject:@"123123" forKey:@"password"];
    
    //NSBundle ：资源文件夹，里面存储的应用程序使用的公共资源。未来传给苹果AppStore的也是这个文件夹。
    NSString *filePath1 = [[NSBundle mainBundle]bundlePath];
//    NSLog(@"%@", filePath1);
    
    /*
     ios8之前NSBundle和沙盒在同一个路径下，但是iOS8之后开始分开放置。
     */
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)dealloc{
    self.window = nil;
    [super dealloc];
}
@end
