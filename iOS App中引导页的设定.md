# iOS App中引导页的设定
首先设置UIImage的size和屏幕的大小相同，设置如下

```
#define Width [UIScreen mainScreen].bounds.size.width
#define Highe [UIScreen mainScreen].bounds.size.height
```
选定一个界面为引导页消失后跳转的界面，设置为根视图FirstViewController

新建继承于UIViewController的文件LanchImageViewController，在LanchImageViewController.h中遵守UIScrollViewDelegate协议。
然后在UIScrollViewDelegate.m中进行设置，

添加滚动视图

```
- (void)addScrollView{
    //创建scrollview对象
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    //设置scrollview的contentSize属性
    scrollView.contentSize = CGSizeMake(Width * 4, Highe);
    //设置scrollview按页滚动
    scrollView.pagingEnabled = YES;
    scrollView.tag = 101;
    //将当前试图控制器设置成scrollview的代理人
    scrollView.delegate = self;
    
    //将4张图片添加scrollview上
    for (int i = 0; i < 4; i++) {
        NSString *string = [NSString stringWithFormat:@"图片%d", i +1];
        UIImageView *image = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:string]]autorelease];
        image.frame = CGRectMake(Width * i, 0, Width, Highe);
        [scrollView addSubview:image];
        if (i == 3) {
            //重要：打开用户交互
            image.userInteractionEnabled = YES;
            //添加轻拍手势
            UITapGestureRecognizer *taG = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)]autorelease];
            [image addGestureRecognizer:taG];
        }
    }
    //添加scrollview
    [self.view addSubview:scrollView];
}
```

设置Image 手势

```
- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
    //创建根视图FirstViewController对象
    FirstViewController *viewF = [[[FirstViewController alloc]init]autorelease];
    //获取应用程序的主窗口
    [UIApplication sharedApplication].keyWindow.rootViewController = viewF;
    
}
```

添加UIPageControl

```
- (void)addPageControl{
    UIPageControl *pageControl = [[[UIPageControl alloc] initWithFrame:CGRectMake(0, Highe - 50, Width, 50)]autorelease];
    //设置 个数
    pageControl.numberOfPages = 4;
    //c,设置选中页码和未被选中页码的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];//选中页码的颜色
    pageControl.pageIndicatorTintColor = [UIColor greenColor];//未被选中页码的颜色
    //添加响应事件
    [pageControl addTarget:self action:@selector(handlePageControlAction:) forControlEvents:UIControlEventValueChanged];
    pageControl.tag = 102;
   //添加pageControl对象
    [self.view addSubview:pageControl];
    
}
```

实现pageControl响应事件

```
- (void)handlePageControlAction:(UIPageControl *)sender{
    //获得UIScrollView对象
    UIScrollView *scrollview = (UIScrollView *)[self.view viewWithTag:101];
    //修改scrollview的偏移量
    [scrollview setContentOffset:CGPointMake(sender.currentPage * Width, 0) animated:YES];
    
}
```
实现scrollview的协议方法

```
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取scrollview x方向的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    //获取当前偏移的图片个数
    NSInteger count = offsetX / Width;
    //获取pageControl对象
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:102];
    //获得下标currentPage
    pageControl.currentPage = count;
}
```


在AppDelegate.m中需要的设置如下
在- (BOOL)application:(UIApplication *)application方法下设置

```
//使用NSUserDefault记录当前的加载是否是第一次加载
    //创建用于持久化存储的对象
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //判断程序是否是第一次加载
    NSNumber *haveLaunch = [userDefaults objectForKey:@"haveLaunch"];
    if ([haveLaunch boolValue]) {
        //将firstViewController对象设置为根视图控制器对象
        FirstViewController *firstV = [[FirstViewController alloc]init];
        self.window.rootViewController = firstV;
        [firstV release];
    }else {
        //将引导页作为根视图
        LanchImageViewController *secondV = [[LanchImageViewController alloc]init];
        self.window.rootViewController = secondV;
        [secondV release];
        //将本次加载记录一下
        [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:@"haveLaunch"];//@(YES)
        
    }
```

