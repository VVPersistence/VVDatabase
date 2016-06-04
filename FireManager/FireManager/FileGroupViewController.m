
//
//  FileGroupViewController.m
//  FireManager
//
//  Created by laouhn on 15/10/27.
//  Copyright (c) 2015年 weiwei. All rights reserved.
//

#import "FileGroupViewController.h"

@interface FileGroupViewController ()

@end

@implementation FileGroupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//获取文件夹的路径
- (NSString *)getGroupFilePath{
    NSString *filePath = NSHomeDirectory();
    filePath = [NSString stringWithFormat:@"%@/Libary/Caches", filePath];
        return [filePath stringByAppendingPathComponent:@"image"];
}


//创建文件夹
- (IBAction)creatFile:(id)sender {
    //1,获取创建文件夹的路径
    NSString *filePath = [self getGroupFilePath];
    //2,创建文件夹管理对象
    NSFileManager *fileM = [NSFileManager defaultManager];
    //3,判断指定路径下是否含有该文件夹，如果没有创建该文件夹
    if (![fileM fileExistsAtPath:filePath]) {
        //创建文件夹
       BOOL result = [fileM createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (result) {
            NSLog(@"文件夹创建成功 %@", filePath);
        }
    }
}


//删除文件夹
- (IBAction)deleFileGroup:(id)sender {
    //1，获取文件夹路径
    NSString *filePath = [self getGroupFilePath];
    //2,创建文件夹管理对象
    NSFileManager *fileM = [NSFileManager defaultManager];
    //3，删除文件夹
    BOOL result = [fileM removeItemAtPath:filePath error:nil];
    if (result) {
        NSLog(@"文件夹删除成功 %@", filePath);
    }
}

//获取Documents文件夹路径
- (NSString *)getDocumentsPath{
    //下面的方法专门用来搜索指定文件夹的路径，因为该方法之前用于mac系统，mac系统下支持多个用户的存在，因此搜索的结果是一个数组，但是我们现在用于手机，手机支持一个用户的存在，因此数组中只有一个对象。
    //参数一：搜索文件夹名字，参数二：搜索的范围（一般是用户），参数三：是否展示详细路径信息。
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES ).firstObject;
    return [filePath stringByAppendingPathComponent:@"image"];//把内容写入content.text中
}


//拷贝文件夹
- (IBAction)copyFile:(id)sender {
    //1，获取文件夹的资源路径
    NSString *sourceF = [self getGroupFilePath];
    //2,获取目的路径
    NSString *destinationPath = [self getDocumentsPath];
    //3，创建文件夹管理对象
    NSFileManager *fileM = [NSFileManager defaultManager];
    //4，拷贝文件夹
   BOOL result = [fileM copyItemAtPath:sourceF toPath:destinationPath error:nil];
    if (result) {
        NSLog(@"文件夹拷贝成功");
    }
}

//移动文件夹
- (IBAction)moveFile:(id)sender {
    //1，获取文件夹的资源路径
    NSString *sourceF = [self getGroupFilePath];
    //2,获取目的路径
    NSString *destinationPath = [self getDocumentsPath];
    //3，创建文件夹管理对象
    NSFileManager *fileM = [NSFileManager defaultManager];
    //4,移动文件夹
   BOOL result = [fileM moveItemAtPath:sourceF toPath:destinationPath error:nil];
    if (result) {
        NSLog(@"文件夹移动成功");
    }
}

//获取文件夹的属性
- (IBAction)attributeFile:(id)sender {
    //1，获取文件夹路径
    NSString *filePath = [self getDocumentsPath];
    //2,创建文件夹管理对象
    NSFileManager *fileM = [NSFileManager defaultManager];
    //3,获取文件夹属性
   NSDictionary *attrDic = [fileM attributesOfItemAtPath:filePath error:nil];
    NSLog(@"%@", attrDic);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
