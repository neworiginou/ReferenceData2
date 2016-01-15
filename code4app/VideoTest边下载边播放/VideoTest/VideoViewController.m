//
//  VideoViewController.m
//  VideoTest
//
//  Created by lkk on 13-11-25.
//  Copyright (c) 2013年 lkk. All rights reserved.
//

#import "VideoViewController.h"
#import "ASIHTTPRequest.h"
#import "AudioButton.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VideoViewController ()

@end

@implementation VideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //视频播放结束通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoFinished) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AudioButton *musicBt = [[AudioButton alloc]initWithFrame:CGRectMake(135, 210, 50, 50)];
    [musicBt addTarget:self action:@selector(videoPlay) forControlEvents:UIControlEventTouchUpInside];
    [musicBt setTag:1];
    [self.view addSubview:musicBt];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)videoPlay{
    NSString *webPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents/Temp"];
    NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents/Cache"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:cachePath])
    {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([fileManager fileExistsAtPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]]) {
        MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]]];
        [self presentMoviePlayerViewControllerAnimated:playerViewController];
        videoRequest = nil;
    }else{
        ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
        AudioButton *musicBt = (AudioButton *)[self.view viewWithTag:1];
        [musicBt startSpin];
        //下载完存储目录
        [request setDownloadDestinationPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]];
        //临时存储目录
        [request setTemporaryFileDownloadPath:[webPath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]];
        [request setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
            [musicBt stopSpin];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setDouble:total forKey:@"file_length"];
            Recordull += size;//Recordull全局变量，记录已下载的文件的大小
            if (!isPlay&&Recordull > 400000) {
                isPlay = !isPlay;
                [self playVideo];
            }
        }];
        UITableView *tableview;
    UITableViewCellStyle
        //断点续载
        [request setAllowResumeForFileDownloads:YES];
        [request startAsynchronous];
        videoRequest = request;
    }
}
- (void)playVideo{
    MPMoviePlayerViewController *playerViewController =[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://127.0.0.1:12345/vedio.mp4"]];/*这是httpServer自己创建的本地服务器端口，可以通过appDelegate实现方法：
    - (void)startServer
    {
        // Start the server (and check for problems)
        
        NSError *error;
        if([httpServer start:&error])
        {
            NSLog(@"Started HTTP Server on port %hu", [httpServer listeningPort]);
        }
        else
        {
            NSLog(@"Error starting HTTP Server: %@", error);
        }
    }*/
    [self presentMoviePlayerViewControllerAnimated:playerViewController];
}

- (void)videoFinished{
    if (videoRequest) {
        isPlay = !isPlay;
        [videoRequest clearDelegatesAndCancel];
        videoRequest = nil;
    }
}
@end
