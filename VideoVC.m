//
//  VideoVC.m
//  
//
//  Created by Ivan Weege on 23/10/15.
//
//

#import "VideoVC.h"
#import <AVFoundation/AVFoundation.h>
#import "ASBPlayerSubtitling.h"

@interface VideoVC ()
@property (weak, nonatomic) IBOutlet UIView *videoPlayerView;
@property (weak, nonatomic) IBOutlet UIButton *subsButton;
@property (strong, nonatomic) IBOutlet ASBPlayerSubtitling *subtitleObject;

@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property(nonatomic) BOOL hasRemovedSubs;

@end

@implementation VideoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPlayer];
}

- (void)setupPlayer
{
    AVPlayer *player;
    NSURL *url;
    
    self.hasRemovedSubs = YES;
    
    url = [[NSBundle mainBundle] URLForResource:@"jellies" withExtension:@"mp4"];
    
    player = [AVPlayer playerWithURL:url];
    
    self.playerLayer = [AVPlayerLayer layer];
    self.playerLayer.contentsGravity = kCAGravityResizeAspect;
    self.playerLayer.player = player;
    [self.videoPlayerView.layer addSublayer:self.playerLayer];
    self.subtitleObject.player = player;
    [player play];
}
- (IBAction)showSubs:(UIButton *)sender {
    
    if(self.hasRemovedSubs == YES) {
        NSURL *subtitlesURL = [[NSBundle mainBundle] URLForResource:@"jellies" withExtension:@"srt"];
        [self.subtitleObject loadSubtitlesAtURL:subtitlesURL error:nil];
        self.subtitleObject.containerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.subtitleObject.containerView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    } else {
        [self.subtitleObject removeSubtitles];
    }
    self.hasRemovedSubs = !self.hasRemovedSubs;
}

- (void)viewDidLayoutSubviews
{
    self.playerLayer.frame = self.videoPlayerView.bounds;
}

@end
