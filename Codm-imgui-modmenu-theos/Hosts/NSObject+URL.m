#import "NSObject+URL.h"
#import "EtcHostsURLProtocol.h"

@implementation NSObject (URL)

+ (void)load
{
    [NSURLProtocol registerClass:[EtcHostsURLProtocol class]];
    [EtcHostsURLProtocol configureHostsWithBlock:^(id <EtcHostsConfiguration> configuration) {
        // Original domains
        [configuration resolveHostName:@"googleads.g.doubleclick.net" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"west-midas.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"west-tdm.codmwest.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"usalive.lobby1.west.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dir.4.401402081.west-gcloud.codm.activision.com" toIPAddress:@"127.0.0.1"];
        
        // Added domains from output.txt - Part 1: Main Tencent and QQ domains
        [configuration resolveHostName:@"down.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dldir.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dldir1.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dldir2.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dldir3.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dldl.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dleid1.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlglobal.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"www.dliat.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlied.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"update1.dlied.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"update2.dlied.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"www.dlied.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"logs.dlied.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mtu.dlied.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlied1.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dns.dlied1.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cloud.dlied1.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlied2.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlied3.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlied4.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlied5.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlied6.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlied7.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlied8.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlied9.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dliedl1.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dlql.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"c.dm.qq.com" toIPAddress:@"127.0.0.1"];
        
        // Game servers and ping services
        [configuration resolveHostName:@"krping.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"meping.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"saping.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hkping.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"euping.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"naping.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hkspeed.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cs.mbgame.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"c.tdm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"lobby.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ig-us-sdkapi.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ig-us-notice.igamecj.com" toIPAddress:@"127.0.0.1"];
        
        // Analytics, telemetry and monitoring
        [configuration resolveHostName:@"oth.eve.mdt.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"apm.wetest.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pingma.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cloud.gsdk.proximabeta.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"tencentgames.helpshift.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"in.voice.gcloudcs.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"qos.hk.gcloudcs.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hk.api.unipay.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"szmg.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pay.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"file-igamecj.akamaized.net" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"file.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hkconfig.gcloud.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"filecdn.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"vmp.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"android.bugly.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"oth.str.mdt.qq.com" toIPAddress:@"127.0.0.1"];
        
        // QQ main service domains
        [configuration resolveHostName:@"mx.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"http.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mx0.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"id.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"test.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"info.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"testing.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ads.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dns.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ipv6.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dns1.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mx1.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dns2.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"news.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"linux.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"download.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ns.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"en.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"f5.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"vm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"alpha.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"gw.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"local.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"help.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ns1.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"home.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ap.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"log.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mail.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"app.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ns2.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"web.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"apps.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"whois.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"auth.qq.com" toIPAddress:@"127.0.0.1"];
        
        // QQ Gaming and PUBG Mobile domains
        [configuration resolveHostName:@"pvp.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pg.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pubg.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pubgm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codol.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cfm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cf.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"tgccfg.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"xj.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"666.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"x5.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hy.cfm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hy.pubgm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pandora.game.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"match.game.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fwcx.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"tmall.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"jsqmt.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"9.url.cn" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"monitor.uu.qq.com" toIPAddress:@"127.0.0.1"];
        
        // Facebook related
        [configuration resolveHostName:@"graph.facebook.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"connect.facebook.net" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"platform-lookaside.fbsbx.com" toIPAddress:@"127.0.0.1"];
        
        // Game CDN domains
        [configuration resolveHostName:@"3gimg.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ztj.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"i.gtimg.cn" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"res.golden.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"img.crawler.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"p2.map.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"js.aq.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"sg.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"wegame.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"image.smoba.qq.com.cloud.tc.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"image.smoba.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mat1.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"x2.tcdn.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"page.coral.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"chijim.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"manhua.qpic.cn" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"tiantang2.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cms.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hszz.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"download.wegame.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cdn.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"image.qsm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"game.sl.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"res.9z.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ava.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cr.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"x2.tc.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"speed.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cfm.qq.com.cloud.tc.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pvp.qq.com.cloud.tc.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"game.gtimg.cn" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fps.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"nz.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"dsgroup7.cfm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"broker.tplay.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cdn.ur.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"res.imtt.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"image.ttwz.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"image.ztj.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"qjjx.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hj.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"9z.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"jieji.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"wt.qq.com" toIPAddress:@"127.0.0.1"];
        
        // Tencent Game domains
        [configuration resolveHostName:@"slg.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ty.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"3.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fuli.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"yi.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"zx.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"res.gamebbs.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ra.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"swa.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pvz.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mo.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"lpl.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pc2.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"m.game.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"yz.lol.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fl1.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"wximg.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"image.lzgjx.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fl3.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mats.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mff.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hyrz.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ffm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"7.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"m2.map.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"qq.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"appmusic.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fl.cdn.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"6j.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"poker.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"53.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"zt.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mir.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ccs.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"peng.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"minigame.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"res.ncdz.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"kof98ol.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"moba.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"sgzr.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ld2.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"xinyue.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hlpsz.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"nb.iso.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"lolriotmall.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"image.qhmy.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"image.slg.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"3366.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"res.x5m.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"rt1.map.gtimg.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pg.qq.com.cloud.tc.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"change.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"zqnba.qq.com.cloud.tc.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cdn.huanle.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"yxwd.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"new.qqhx.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"x5m.qq.com" toIPAddress:@"127.0.0.1"];
        
        // AntiCheat related domains - Most important for blocking
        [configuration resolveHostName:@"csoversea.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cs.mbgame.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cs.mainconn.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cs.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pubg.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"tpns.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"intl.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"defender.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"defender1.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"down.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"downintl.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"nj.cschannel.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"usa.csoversea.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"eu.csoversea.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mea.csoversea.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hk.csoversea.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"as.csoversea.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"kr.csoversea.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"sa.csoversea.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"riot-mtp.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"backup-riot-mtp.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"uic-cn.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"uic.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"court.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cschannel.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"puffer.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"intl-cschannel.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"intlcs.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"proxyrule.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ping.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"speedtest.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"overseas-report.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"astat.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cs.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"anticheatlog.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"intl-bgp-sg.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"gameguardian.net" toIPAddress:@"127.0.0.1"];
        
        // GameGuard related domains
        [configuration resolveHostName:@"gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"nj.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"sh.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"sz.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cd.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"gz.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"wh.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hb.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cs.nj.mainconn.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cs.sh.mainconn.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cs.cd.mainconn.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cs.sz.mainconn.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"gameguardian.net" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"www.gameguardian.net" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"forum.gameguardian.net" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"nprotect.netmarble.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"nprotect.mqoo.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"nprotect.cdnetworks.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"gamesecurity.gameclub.ph" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hackshield.hanbiton.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hackshield.ahnlab.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hs.ahnlab.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"secureguard.game.naver.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"gamemon.perfectworld.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"guard.game.com.cn" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"guard.games.com.cn" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"guard.wanmei.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"xigncode.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"xigncode.inca.co.kr" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"xigncode3.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"astat.bugly.cros.wr.pvp.net" toIPAddress:@"127.0.0.1"];
        
        // Additional AntiCheat Systems
        [configuration resolveHostName:@"easyanticheat.net" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"easy.ac" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"www.easy.ac" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"download.easyanticheat.net" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"battlEye.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"www.battleye.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"anti-cheat.untrustedmodders.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"vac.valvesoftware.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"acapi.playersafety.eamobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"aclog.playersafety.eamobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fairplay.gameclub.ph" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pgc.playersafety.eamobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"safeweb.norton.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"hackertest.securityspace.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"anticheat.mp.microsoft.com" toIPAddress:@"127.0.0.1"];
        
        // AntiCheat Report Systems & Services
        [configuration resolveHostName:@"report.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"overseas-report.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"anticheatlog.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"reportgw.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"tencentgames.report.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"reporter.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.activeticket.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"gamereport.activeticket.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"reportprvgw.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cheaterreport.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"userreport.battleye.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.huatuo.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.syzs.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"abuse.easyanticheat.net" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.gamebbs.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report-api.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report-web.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"reportlog.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"reportlog.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fraudreport.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"reporting.nexoneu.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"playerreports.activision.com" toIPAddress:@"127.0.0.1"];
        
        // Security Verification and Authentication
        [configuration resolveHostName:@"security-verification.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"security-center.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"safeguard.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"security.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"safetyverify.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"verify.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"verify.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"verify.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"verify.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"securitycenter.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"crypt.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"verify-api.midasbuy.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"securesupport.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"securityvalidate.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"securelogin.garena.com" toIPAddress:@"127.0.0.1"];
        
        // Game Fair Play and Account Safety
        [configuration resolveHostName:@"fairplay.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fairplay.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fairplay.tencent.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fairplay.proximabeta.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fairplay.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fairplay.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fairplay.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fairplay.battleye.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fairplay.easyanticheat.net" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"safeplay.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"safeplay.tencent.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"safe.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"safe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"safegame.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"account-safety.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"accountsafety.activision.com" toIPAddress:@"127.0.0.1"];
        
        // Anti-Cheat Detection & Monitoring
        [configuration resolveHostName:@"detect.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"detection.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"detector.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"detectservice.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"scan.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"scanning.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"scanner.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"scan.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"scanning.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"scanner.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"mlscanservice.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"detectml.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"monitor.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"monitor.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"gamemonitor.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"detectionservice.proximabeta.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"detect.battleye.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"scan.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"scanner.codm.activision.com" toIPAddress:@"127.0.0.1"];
        
        // Game Integrity and System Checks
        [configuration resolveHostName:@"integrity.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fileintegrity.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"integritycheck.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"systemcheck.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"syscheck.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"integrityscan.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"gamesystem.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"gamevalidation.tencent.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"app-validator.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"validator.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"validator.tencent.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"memorycheck.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"processmonitor.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"memoryscan.gamesafe.qq.com" toIPAddress:@"127.0.0.1"];
        
        // Ban & Penalty Systems
        [configuration resolveHostName:@"ban.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ban.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"banservice.proximabeta.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"bantool.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"penalty.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ban.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"banappeal.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"punishment.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"punish.igamecj.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"penalty.tencent.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"baninfo.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"bansystem.proximabeta.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"accountban.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"banreview.battleye.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"banchecker.pubgmobile.com" toIPAddress:@"127.0.0.1"];
        
        // Call of Duty Mobile (CODM) Main Domains
        [configuration resolveHostName:@"codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codmobile.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"callofdutymobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cod.game.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.game.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"wwwcodmcom-a.akamaihd.net" toIPAddress:@"127.0.0.1"];
        
        // CODM Regional Servers
        [configuration resolveHostName:@"codm-na.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm-eu.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm-as.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"east.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"west.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"eu.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ap.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"sa.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"as.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"kr.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.garena.co.id" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.garena.co.th" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.garena.tw" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.garena.ph" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.garena.vn" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.garena.my" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.garena.in" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.garena.jp" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codmcn.com" toIPAddress:@"127.0.0.1"];
        
        // CODM Game Servers
        [configuration resolveHostName:@"codmlobby.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"lobby.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"eu-lobby.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"na-lobby.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"as-lobby.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"sa-lobby.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codmserver.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"matchmaking.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codmwest.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codmeast.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"west-tdm.codmwest.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"west-br.codmwest.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"west-lobby.codmwest.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"east-tdm.codmeast.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"east-br.codmeast.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"east-lobby.codmeast.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"eu-tdm.codmeu.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"eu-br.codmeu.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"eu-lobby.codmeu.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"tgpa.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"garena-codm-live.op.gg" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"na-online.cod.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"eu-online.cod.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"as-online.cod.qq.com" toIPAddress:@"127.0.0.1"];
        
        // CODM Ping/Connection Check
        [configuration resolveHostName:@"ping.codmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"pingtest.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"speedtest.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codmping.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ping.codmwest.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ping.codmeast.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ping-na.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ping-eu.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ping-as.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"speed.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"latency.codm.activision.com" toIPAddress:@"127.0.0.1"];
        
        // CODM CDN & Asset Delivery
        [configuration resolveHostName:@"assets.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cdn.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cdn1.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cdn2.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cdn3.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"static.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"images.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"content.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"assetcdn.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"assets.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm-assets.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"resource.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"res.codm.qq.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cdnassets.codmobile.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.res.netease.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"akamai-codm-content.akamaized.net" toIPAddress:@"127.0.0.1"];
        
        // CODM Update Servers
        [configuration resolveHostName:@"update.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"patchnotes.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"patch.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"updates.codmobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"version.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"updateserver.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"patchfiles.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"app-update.codm.activision.com" toIPAddress:@"127.0.0.1"];
        
        // CODM API & Services
        [configuration resolveHostName:@"api.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"api.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"services.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"api-codm.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"connect.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"profile-codm.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"leaderboard.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"stats.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"stats.callofdutymobile.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"profile.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"friends.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"clan.codm.activision.com" toIPAddress:@"127.0.0.1"];
        
        // CODM Battle Pass & Store
        [configuration resolveHostName:@"store.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"shop.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"store.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"shop.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"battlepass.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"bp.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"purchase.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"payment.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"payment-api.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"iap.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codmshop.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cp.codm.qq.com" toIPAddress:@"127.0.0.1"];
        
        // CODM Events & Tournaments
        [configuration resolveHostName:@"events.callofduty.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"event.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"events.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"tournament.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"worldchampionship.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"championship.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"esport.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"reward.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codmworldcup.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codmwc.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"tournaments.callofdutymobile.com" toIPAddress:@"127.0.0.1"];
        
        // CODM Garena Specific
        [configuration resolveHostName:@"codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"callofdutymobile.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"speed.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"banpickmap.codm.garena.co.id" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"event.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"esports.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"tournament.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"championship.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"reward.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"shop.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"battlepass.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"update.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"api.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"accounts.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"login.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"leaderboard.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"stats.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"cdn.codm.garena.com" toIPAddress:@"127.0.0.1"];
        
        // CODM Anti-Cheat & Security
        [configuration resolveHostName:@"security.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"anticheat.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"codm.mbgame.anticheatexpert.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"verify.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"integrity.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"scan.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"scanner.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"detect.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"fairplay.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"report.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"ban.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"penalty.codm.activision.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"security.codm.garena.com" toIPAddress:@"127.0.0.1"];
        [configuration resolveHostName:@"anticheat.codm.garena.com" toIPAddress:@"127.0.0.1"];
    }];
}
   

@end
