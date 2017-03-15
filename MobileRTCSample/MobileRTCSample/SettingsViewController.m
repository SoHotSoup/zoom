//
//  SettingsViewController.m
//  ZoomSDKSample
//
//  Created by Robust Hu on 7/6/15.
//  Copyright (c) 2015 Zoom Video Communications, Inc. All rights reserved.
//

#import "SettingsViewController.h"
#import "LanguaguePickerViewController.h"
#import <MobileRTC/MobileRTC.h>

@interface SettingsViewController ()

@property (retain, nonatomic) UITableViewCell *autoConnectAudioCell;
@property (retain, nonatomic) UITableViewCell *muteAudioCell;
@property (retain, nonatomic) UITableViewCell *muteVideoCell;
@property (retain, nonatomic) UITableViewCell *driveModeCell;
@property (retain, nonatomic) UITableViewCell *callInCell;
@property (retain, nonatomic) UITableViewCell *callOutCell;

@property (retain, nonatomic) UITableViewCell *titleHiddenCell;
@property (retain, nonatomic) UITableViewCell *leaveHiddenCell;
@property (retain, nonatomic) UITableViewCell *inviteHiddenCell;
@property (retain, nonatomic) UITableViewCell *shareHiddenCell;
@property (retain, nonatomic) UITableViewCell *audioHiddenCell;
@property (retain, nonatomic) UITableViewCell *videoHiddenCell;
@property (retain, nonatomic) UITableViewCell *participantHiddenCell;
@property (retain, nonatomic) UITableViewCell *moreHiddenCell;

@property (retain, nonatomic) UITableViewCell *topBarHiddenCell;
@property (retain, nonatomic) UITableViewCell *botBarHiddenCell;

@property (retain, nonatomic) UITableViewCell *enableKubiCell;
@property (retain, nonatomic) UITableViewCell *thumbnailCell;
@property (retain, nonatomic) UITableViewCell *hostLeaveCell;

@property (retain, nonatomic) UITableViewCell *languageCell;

@property (retain, nonatomic) NSArray *itemArray;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Settings", @"");
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDone:)];
    [self.navigationItem setLeftBarButtonItem:closeItem];
    [closeItem release];
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@[[self autoConnectAudioCell]]];
    [array addObject:@[[self muteAudioCell]]];
    [array addObject:@[[self muteVideoCell]]];
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
        [array addObject:@[[self driveModeCell]]];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        [array addObject:@[[self enableKubiCell]]];
    [array addObject:@[[self thumbnailCell]]];
    [array addObject:@[[self hostLeaveCell]]];
    
    NSMutableArray *ma = [NSMutableArray array];
    [ma addObject:[self titleHiddenCell]];
    [ma addObject:[self leaveHiddenCell]];
    [ma addObject:[self audioHiddenCell]];
    [ma addObject:[self videoHiddenCell]];
    [ma addObject:[self inviteHiddenCell]];
    [ma addObject:[self participantHiddenCell]];
    [ma addObject:[self moreHiddenCell]];
    [ma addObject:[self shareHiddenCell]];
    [ma addObject:[self topBarHiddenCell]];
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
    {
        [ma addObject:[self botBarHiddenCell]];
    }
    [array addObject:ma];
    
    [array addObject:@[[self callInCell], [self callOutCell]]];
    
    [array addObject:@[[self languageCell]]];
    
    self.itemArray = array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Table view cells

- (UITableViewCell*)autoConnectAudioCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL isAutoConnected = [settings autoConnectInternetAudio];

    if (!_autoConnectAudioCell)
    {
        _autoConnectAudioCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _autoConnectAudioCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _autoConnectAudioCell.textLabel.text = NSLocalizedString(@"Auto Connect Internet Audio", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:isAutoConnected animated:NO];
        [sv addTarget:self action:@selector(onAutoConnectAudio:) forControlEvents:UIControlEventValueChanged];
        _autoConnectAudioCell.accessoryView = sv;
    }
    
    return _autoConnectAudioCell;
}

- (UITableViewCell*)muteAudioCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL isMuted = [settings muteAudioWhenJoinMeeting];
    
    if (!_muteAudioCell)
    {
        _muteAudioCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _muteAudioCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _muteAudioCell.textLabel.text = NSLocalizedString(@"Always Mute My Microphone", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:isMuted animated:NO];
        [sv addTarget:self action:@selector(onMuteAudio:) forControlEvents:UIControlEventValueChanged];
        _muteAudioCell.accessoryView = sv;
    }
    
    return _muteAudioCell;
}

- (UITableViewCell*)muteVideoCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL isMuted = [settings muteVideoWhenJoinMeeting];
    
    if (!_muteVideoCell)
    {
        _muteVideoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _muteVideoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _muteVideoCell.textLabel.text = NSLocalizedString(@"Always Mute My Video", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:isMuted animated:NO];
        [sv addTarget:self action:@selector(onMuteVideo:) forControlEvents:UIControlEventValueChanged];
        _muteVideoCell.accessoryView = sv;
    }
    
    return _muteVideoCell;
}

- (UITableViewCell*)driveModeCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL disabled = [settings driveModeDisabled];
    
    if (!_driveModeCell)
    {
        _driveModeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _driveModeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _driveModeCell.textLabel.text = NSLocalizedString(@"Disable Driving Mode", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:disabled animated:NO];
        [sv addTarget:self action:@selector(onDisableDriveMode:) forControlEvents:UIControlEventValueChanged];
        _driveModeCell.accessoryView = sv;
    }
    
    return _driveModeCell;
}

- (UITableViewCell*)callInCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL disabled = [settings callInDisabled];
    
    if (!_callInCell)
    {
        _callInCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _callInCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _callInCell.textLabel.text = NSLocalizedString(@"Disable Call in", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:disabled animated:NO];
        [sv addTarget:self action:@selector(onDisableCallIn:) forControlEvents:UIControlEventValueChanged];
        _callInCell.accessoryView = sv;
    }
    
    return _callInCell;
}

- (UITableViewCell*)callOutCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL disabled = [settings callOutDisabled];
    
    if (!_callOutCell)
    {
        _callOutCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _callOutCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _callOutCell.textLabel.text = NSLocalizedString(@"Disable Call Out", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:disabled animated:NO];
        [sv addTarget:self action:@selector(onDisableCallOut:) forControlEvents:UIControlEventValueChanged];
        _callOutCell.accessoryView = sv;
    }
    
    return _callOutCell;
}

- (UITableViewCell*)titleHiddenCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings meetingTitleHidden];
    
    if (!_titleHiddenCell)
    {
        _titleHiddenCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _titleHiddenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _titleHiddenCell.textLabel.text = NSLocalizedString(@"Hide Meeting Title", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideMeetingTitle:) forControlEvents:UIControlEventValueChanged];
        _titleHiddenCell.accessoryView = sv;
    }
    
    return _titleHiddenCell;
}

- (UITableViewCell*)leaveHiddenCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings meetingLeaveHidden];
    
    if (!_leaveHiddenCell)
    {
        _leaveHiddenCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _leaveHiddenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _leaveHiddenCell.textLabel.text = NSLocalizedString(@"Hide Meeting Leave", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideMeetingLeave:) forControlEvents:UIControlEventValueChanged];
        _leaveHiddenCell.accessoryView = sv;
    }
    
    return _leaveHiddenCell;
}

- (UITableViewCell*)audioHiddenCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings meetingAudioHidden];
    
    if (!_audioHiddenCell)
    {
        _audioHiddenCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _audioHiddenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _audioHiddenCell.textLabel.text = NSLocalizedString(@"Hide Meeting Audio", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideMeetingAudio:) forControlEvents:UIControlEventValueChanged];
        _audioHiddenCell.accessoryView = sv;
    }
    
    return _audioHiddenCell;
}

- (UITableViewCell*)videoHiddenCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings meetingVideoHidden];
    
    if (!_videoHiddenCell)
    {
        _videoHiddenCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _videoHiddenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _videoHiddenCell.textLabel.text = NSLocalizedString(@"Hide Meeting Video", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideMeetingVideo:) forControlEvents:UIControlEventValueChanged];
        _videoHiddenCell.accessoryView = sv;
    }
    
    return _videoHiddenCell;
}

- (UITableViewCell*)inviteHiddenCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings meetingInviteHidden];
    
    if (!_inviteHiddenCell)
    {
        _inviteHiddenCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _inviteHiddenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _inviteHiddenCell.textLabel.text = NSLocalizedString(@"Hide Meeting Invite", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideMeetingInvite:) forControlEvents:UIControlEventValueChanged];
        _inviteHiddenCell.accessoryView = sv;
    }
    
    return _inviteHiddenCell;
}

- (UITableViewCell*)participantHiddenCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings meetingParticipantHidden];
    
    if (!_participantHiddenCell)
    {
        _participantHiddenCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _participantHiddenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _participantHiddenCell.textLabel.text = NSLocalizedString(@"Hide Meeting Participant", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideMeetingParticipant:) forControlEvents:UIControlEventValueChanged];
        _participantHiddenCell.accessoryView = sv;
    }
    
    return _participantHiddenCell;
}

- (UITableViewCell*)shareHiddenCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings meetingShareHidden];
    
    if (!_shareHiddenCell)
    {
        _shareHiddenCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _shareHiddenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _shareHiddenCell.textLabel.text = NSLocalizedString(@"Hide Meeting Share", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideMeetingShare:) forControlEvents:UIControlEventValueChanged];
        _shareHiddenCell.accessoryView = sv;
    }
    
    return _shareHiddenCell;
}

- (UITableViewCell*)moreHiddenCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings meetingMoreHidden];
    
    if (!_moreHiddenCell)
    {
        _moreHiddenCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _moreHiddenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _moreHiddenCell.textLabel.text = NSLocalizedString(@"Hide Meeting More", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideMeetingMore:) forControlEvents:UIControlEventValueChanged];
        _moreHiddenCell.accessoryView = sv;
    }
    
    return _moreHiddenCell;
}

- (UITableViewCell*)topBarHiddenCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings topBarHidden];
    
    if (!_topBarHiddenCell)
    {
        _topBarHiddenCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _topBarHiddenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _topBarHiddenCell.textLabel.text = NSLocalizedString(@"Hide Meeting TopBar", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideMeetingTopBar:) forControlEvents:UIControlEventValueChanged];
        _topBarHiddenCell.accessoryView = sv;
    }
    
    return _topBarHiddenCell;
}

- (UITableViewCell*)botBarHiddenCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings bottomBarHidden];
    
    if (!_botBarHiddenCell)
    {
        _botBarHiddenCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _botBarHiddenCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _botBarHiddenCell.textLabel.text = NSLocalizedString(@"Hide Meeting BottomBar", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideMeetingBotBar:) forControlEvents:UIControlEventValueChanged];
        _botBarHiddenCell.accessoryView = sv;
    }
    
    return _botBarHiddenCell;
}

- (UITableViewCell*)enableKubiCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings enableKubi];
    
    if (!_enableKubiCell)
    {
        _enableKubiCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _enableKubiCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _enableKubiCell.textLabel.text = NSLocalizedString(@"Enable Kubi Device", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onEnableKubi:) forControlEvents:UIControlEventValueChanged];
        _enableKubiCell.accessoryView = sv;
    }
    
    return _enableKubiCell;
}

- (UITableViewCell*)thumbnailCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings thumbnailHidden];
    
    if (!_thumbnailCell)
    {
        _thumbnailCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _thumbnailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _thumbnailCell.textLabel.text = NSLocalizedString(@"Hide Thumbnail Video", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideThumbnail:) forControlEvents:UIControlEventValueChanged];
        _thumbnailCell.accessoryView = sv;
    }
    
    return _thumbnailCell;
}

- (UITableViewCell*)hostLeaveCell
{
    MobileRTCMeetingSettings *settings = [[MobileRTC sharedRTC] getMeetingSettings];
    if (!settings)
        return nil;
    
    BOOL hidden = [settings hostLeaveHidden];
    
    if (!_hostLeaveCell)
    {
        _hostLeaveCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _hostLeaveCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _hostLeaveCell.textLabel.text = NSLocalizedString(@"Host Hide Leave Meeting", @"");
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:hidden animated:NO];
        [sv addTarget:self action:@selector(onHideHostLeave:) forControlEvents:UIControlEventValueChanged];
        _hostLeaveCell.accessoryView = sv;
    }
    
    return _hostLeaveCell;
}

- (UITableViewCell*)languageCell
{
    if (!_languageCell)
    {
        _languageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _languageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _languageCell.textLabel.text = NSLocalizedString(@"Select Language", @"");
        _languageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return _languageCell;
}


- (void)onAutoConnectAudio:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[[MobileRTC sharedRTC] getMeetingSettings] setAutoConnectInternetAudio:sv.on];
}

- (void)onMuteAudio:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[[MobileRTC sharedRTC] getMeetingSettings] setMuteAudioWhenJoinMeeting:sv.on];
}

- (void)onMuteVideo:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[[MobileRTC sharedRTC] getMeetingSettings] setMuteVideoWhenJoinMeeting:sv.on];
}

- (void)onDisableDriveMode:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[[MobileRTC sharedRTC] getMeetingSettings] disableDriveMode:sv.on];
}

- (void)onDisableCallIn:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[[MobileRTC sharedRTC] getMeetingSettings] disableCallIn:sv.on];
}

- (void)onDisableCallOut:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[[MobileRTC sharedRTC] getMeetingSettings] disableCallOut:sv.on];
}

- (void)onHideMeetingTitle:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].meetingTitleHidden = sv.on;
}

- (void)onHideMeetingLeave:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].meetingLeaveHidden = sv.on;
}

- (void)onHideMeetingAudio:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].meetingAudioHidden = sv.on;
}

- (void)onHideMeetingVideo:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].meetingVideoHidden = sv.on;
}

- (void)onHideMeetingInvite:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].meetingInviteHidden = sv.on;
}

- (void)onHideMeetingParticipant:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].meetingParticipantHidden = sv.on;
}

- (void)onHideMeetingShare:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].meetingShareHidden = sv.on;
}

- (void)onHideMeetingMore:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].meetingMoreHidden = sv.on;
}

- (void)onHideMeetingTopBar:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].topBarHidden = sv.on;
}

- (void)onHideMeetingBotBar:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].bottomBarHidden = sv.on;
}

- (void)onEnableKubi:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].enableKubi = sv.on;
}

- (void)onHideThumbnail:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].thumbnailHidden = sv.on;
}

- (void)onHideHostLeave:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[MobileRTC sharedRTC] getMeetingSettings].hostLeaveHidden = sv.on;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.itemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.itemArray[section];
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = self.itemArray[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return NSLocalizedString(@"Auto Connect Internet Audio Setting", @"");
    }
    
    if (section == 1)
    {
        return NSLocalizedString(@"Always mute my microphone when joining others' meeting", @"");
    }
    
    if (section == 2)
    {
        return NSLocalizedString(@"Always mute my video when joining others' meeting", @"");
    }
    
    if (section == 3 && [UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPad)
    {
        return NSLocalizedString(@"Driving Mode Setting", @"");
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = self.itemArray[indexPath.section][indexPath.row];
    if (cell == _languageCell)
    {
        LanguaguePickerViewController * languaguePickerViewController = [[LanguaguePickerViewController alloc]init];
        [self.navigationController pushViewController:languaguePickerViewController animated:YES];
        [languaguePickerViewController release];
    }
}
@end
