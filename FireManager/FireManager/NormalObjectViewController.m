//
//  NormalObjectViewController.m
//  FireManager
//
//  Created by laouhn on 15/10/27.
//  Copyright (c) 2015年 weiwei. All rights reserved.
//

#import "NormalObjectViewController.h"

@interface NormalObjectViewController ()
@property (retain, nonatomic) IBOutlet UITextField *firstTextField;
@property (retain, nonatomic) IBOutlet UITextField *secondTextField;

@end

@implementation NormalObjectViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
//获取Documents文件夹路径
- (NSString *)getDocumentsPath{
    //下面的方法专门用来搜索指定文件夹的路径，因为该方法之前用于mac系统，mac系统下支持多个用户的存在，因此搜索的结果是一个数组，但是我们现在用于手机，手机支持一个用户的存在，因此数组中只有一个对象。
    //参数一：搜索文件夹名字，参数二：搜索的范围（一般是用户），参数三：是否展示详细路径信息。
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES ).firstObject;
    return [filePath stringByAppendingPathComponent:@"content.text"];//把内容写入content.text中
}


         /********************字符串的读写*********************/

//字符串写入
- (IBAction)stringWrite:(id)sender {
    //1，获取写入文件的路径
    NSString *filePath = [self getDocumentsPath];
    //2，将字符串写入指定的文件
    /*
     atomically:数据每次写入文档之前都会写入一个临时的文件，人后将临时的文件中的内容替换掉原文件中的内容，这样可以保证每次写入的数据都是完整的。
     */
   BOOL result1 = [self.firstTextField.text writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    BOOL result2 = [self.secondTextField.text writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (result1 == YES && result2 == YES) {
        NSLog(@"字符串写入成功 %@", filePath);
    }else{
        NSLog(@"字符串写入失败");
    }
}

//字符串读取
- (IBAction)stringRead:(id)sender {
    //从指定文件中读取数据
    //1，获取文件的路径
     NSString *filePath = [self getDocumentsPath];
    
    //方法一：转化为二进制读取
//    //2，开始读取数据
//    NSData *data = [NSData dataWithContentsOfFile:filePath];//二进制数据
//    //3，将二进制数据转换成字符串
//    self.secondTextField.text = [[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]autorelease];
    
    //方法二：从文档里面直接读取
    self.secondTextField.text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
}

             /********************数组的读写*********************/

//数组的写入
- (IBAction)arrayWrite:(id)sender {
    //1，获取文件路径
    NSString *filePath = [self getDocumentsPath];
    //创建数组对象（将数组/字典中的内容写入到文件的时候必须保证数组/字典中的对象必须是简单对象）
    NSArray *contents = @[self.firstTextField.text , self.secondTextField.text];
   //数组写入
    BOOL result = [contents writeToFile:filePath atomically:YES];
    if (result == YES) {
        NSLog(@"数组写入成功 %@", filePath);
    }else{
        NSLog(@"数组写入失败");
    }
}

//数组的读取
- (IBAction)arrayRead:(id)sender {
    //1，获取文件路径
    NSString *filePath = [self getDocumentsPath];
    //2，读取文件中数据
    NSArray *contents = [NSArray arrayWithContentsOfFile:filePath];
    self.firstTextField.text = contents.firstObject;
    self.secondTextField.text = contents.lastObject;
}

         /********************字典的读写*********************/

//字典的写入
- (IBAction)dictionaryWrite:(id)sender {
    //1，获取文件路径
    NSString *filePath = [self getDocumentsPath];
    NSDictionary *contents = @{@"key1" : self.firstTextField.text , @"key2" :self.secondTextField.text};
    //写入
    BOOL result = [contents writeToFile:filePath atomically:YES];
    if (result == YES) {
        NSLog(@"字典写入成功 %@", filePath);
    }else{
        NSLog(@"字典写入失败");
    }
}

//字典读取
- (IBAction)dictionaryRead:(id)sender {
    //1，获取文件路径
    NSString *filePath = [self getDocumentsPath];
    //2，读取
    NSDictionary *contents = [NSDictionary dictionaryWithContentsOfFile:filePath];
    self.firstTextField.text = contents[@"key1"];
    self.secondTextField.text = contents[@"key2"];
}

       /********************二进制的读写*********************/

//二进制写入
- (IBAction)dataWrite:(id)sender {
    //1，获取文件路径
    NSString *filePath = [self getDocumentsPath];
    //2，将字符串转换成二进制数据
    NSData *dataText = [self.firstTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    //3,写入
    BOOL result = [dataText writeToFile:filePath atomically:YES];
    if (result == YES) {
        NSLog(@"二进制写入成功 %@", filePath);
    }else{
        NSLog(@"二进制写入失败");
    }

}

//二进制读取
- (IBAction)dataRead:(id)sender {
    //1，获取文件路径
    NSString *filePath = [self getDocumentsPath];
    //2，从文件中读取数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //3,将NSData转换成NSString
    self.firstTextField.text = [[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]autorelease];
}

//回收键盘，取消第一响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

- (void)dealloc {
    [_firstTextField release];
    [_secondTextField release];
    [super dealloc];
}
@end
