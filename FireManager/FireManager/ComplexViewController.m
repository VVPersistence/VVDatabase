//
//  ComplexViewController.m
//  FireManager
//
//  Created by laouhn on 15/10/27.
//  Copyright (c) 2015年 weiwei. All rights reserved.
//

#import "ComplexViewController.h"
#import "person.h"
@interface ComplexViewController ()
@property (retain, nonatomic) IBOutlet UITextField *nameText;
@property (retain, nonatomic) IBOutlet UITextField *genderText;
@property (retain, nonatomic) IBOutlet UITextField *ageText;

@end

@implementation ComplexViewController

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


//归档操作
- (IBAction)archiverAction:(id)sender {
    //创建Person对象
    person *person1 = [[[person alloc]init]autorelease];
    person1.name = self.nameText.text;
    person1.gender = self.genderText.text;
    person1.age = self.ageText.text.integerValue;
    //1,创建归档对象
    NSMutableData *dataM = [[[NSMutableData alloc]initWithCapacity:0]autorelease];
    NSKeyedArchiver *archiver = [[[NSKeyedArchiver alloc]initForWritingWithMutableData:dataM]autorelease];
    //2,开始进行归档
    [archiver encodeObject:person1 forKey:@"person1"];
    //3,结束归档操作
    [archiver finishEncoding];
    //4,将dataM写入到文件中
    //获取文件路径
    NSString *filePath = [self getDocumentsPath];
    //写入到文件
   BOOL result = [dataM writeToFile:filePath atomically:YES];
    if (result == YES) {
        NSLog(@"数据写入成功 %@", filePath);
    }else{
        NSLog(@"数据写入失败");
    }

}

//反归档操作
- (IBAction)unarchiverAction:(id)sender {
    //1，读取文件数据
    //获取文件路径
    NSString *filePath = [self getDocumentsPath];
    NSMutableData *dataM = [NSMutableData dataWithContentsOfFile:filePath];
    //2,创建一个反归档对象
    NSKeyedUnarchiver *unarchiver = [[[NSKeyedUnarchiver alloc]initForReadingWithData:dataM]autorelease];
    //3.开始进行反归档操作
    person *person1 = [unarchiver decodeObjectForKey:@"person1"];
    self.nameText.text = person1.name;
    self.genderText.text = person1.gender;
    self.ageText.text = [NSString stringWithFormat:@"%ld", person1.age];
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
    [_nameText release];
    [_genderText release];
    [_ageText release];
    [super dealloc];
}
@end
