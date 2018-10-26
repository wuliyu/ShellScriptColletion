#! /bin/bash

sin=0
for (( i = 1; i < 297; i++ )); do
	url=https://u.y.qq.com/cgi-bin/musicu.fcg?data=%7B%22comm%22%3A%7B%22ct%22%3A24%2C%22cv%22%3A10000%7D%2C%22singerList%22%3A%7B%22module%22%3A%22Music.SingerListServer%22%2C%22method%22%3A%22get_singer_list%22%2C%22param%22%3A%7B%22area%22%3A-100%2C%22sex%22%3A-100%2C%22genre%22%3A-100%2C%22index%22%3A-100%2C%22sin%22%3A${sin}%2C%22cur_page%22%3A${i}%7D%7D%7D
	singermids=$(curl -s ${url} -H 'authority: u.y.qq.com' -H 'pragma: no-cache' -H 'cache-control: no-cache' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: zh-CN,zh;q=0.9,en;q=0.8,und;q=0.7' -H 'cookie: pgv_pvi=542989312; pgv_si=s4970791936; ptisp=cnc; ptui_loginuin=2731998103; pt2gguin=o2731998103; RK=9M7s/oy1nh; ptcz=f6af2f04959164520ae41420ff519ed25aabf0dc8229afae8fcfb13cd7bdc9ee; pgv_info=ssid=s4620675730; ts_refer=www.baidu.com/link; pgv_pvid=8842741264; ts_uid=1573866863; qqmusic_fromtag=66; player_exist=1; yq_playschange=0; yq_playdata=; yq_index=4; yplayer_open=0; yqq_stat=0; ts_last=y.qq.com/portal/singer_list.html' --compressed | grep -o '\"00[a-zA-Z0-9]\{12\}\"' | grep -o '00[a-zA-Z0-9]\{12\}')
	for mid in ${singermids[@]}; do
		echo ${mid} >> singers.txt
	done
	((sin=sin+80))
done

singermids=$(cat 'singers.txt' | grep -o '00[a-zA-Z0-9]\{12\}')
for i in ${singermids[@]}; do
	songmids=$(curl -s "https://c.y.qq.com/v8/fcg-bin/fcg_v8_singer_track_cp.fcg?singermid=${i}&order=listen&begin=0&num=1000" -H 'pragma: no-cache' -H 'cache-control: no-cache' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: zh-CN,zh;q=0.9,en;q=0.8,und;q=0.7' -H 'cookie: pgv_pvi=542989312; pgv_si=s4970791936; ptisp=cnc; ptui_loginuin=2731998103; pt2gguin=o2731998103; RK=9M7s/oy1nh; ptcz=f6af2f04959164520ae41420ff519ed25aabf0dc8229afae8fcfb13cd7bdc9ee; pgv_info=ssid=s4620675730; ts_refer=www.baidu.com/link; pgv_pvid=8842741264; ts_uid=1573866863; qqmusic_fromtag=66; player_exist=1; yq_playschange=0; yq_playdata=; yq_index=4; yplayer_open=0; yqq_stat=0; ts_last=y.qq.com/n/yqq/singer/000aHmbL2aPXWH.html' --compressed | grep -o '\"songmid\":\"[a-zA-Z0-9]\{14\}\"' | grep -o '00[a-zA-Z0-9]\{12\}')
	for songmid in ${songmids[@]}; do
		echo ${songmid} >> songs.txt
	done
done

songmids=$(cat 'songs.txt' | grep -o '00[a-zA-Z0-9]\{12\}')
for songmid in ${songmids[@]}; do
	vkey=$(curl https://u.y.qq.com/cgi-bin/musicu.fcg?callback=getplaysongvkey5923284177984609&g_tk=1742427095&jsonpCallback=getplaysongvkey5923284177984609&loginUin=2731998103&hostUin=0&format=jsonp&inCharset=utf8&outCharset=utf-8&notice=0&platform=yqq&needNewCode=0&data=%7B%22req_0%22%3A%7B%22module%22%3A%22vkey.GetVkeyServer%22%2C%22method%22%3A%22CgiGetVkey%22%2C%22param%22%3A%7B%22guid%22%3A%228842741264%22%2C%22songmid%22%3A%5B%22${songmid}%22%5D%2C%22songtype%22%3A%5B0%5D%2C%22uin%22%3A%222731998103%22%2C%22loginflag%22%3A1%2C%22platform%22%3A%2220%22%7D%7D%2C%22comm%22%3A%7B%22uin%22%3A2731998103%2C%22format%22%3A%22json%22%2C%22ct%22%3A20%2C%22cv%22%3A0%7D%7D -H 'pragma: no-cache' -H 'cookie: pgv_pvi=542989312; pgv_si=s4970791936; ptisp=cnc; ptui_loginuin=2731998103; pt2gguin=o2731998103; RK=9M7s/oy1nh; ptcz=f6af2f04959164520ae41420ff519ed25aabf0dc8229afae8fcfb13cd7bdc9ee; pgv_info=ssid=s4620675730; pgv_pvid=8842741264; ts_uid=1573866863; qqmusic_fromtag=66; uin=o2731998103; skey=@QFObpbpEt; luin=o2731998103; lskey=00010000ee2db2a0cd2040a9eceafa50923bde4ef747db6c88c188242e7f0d608c7a2d22dfc20c138e932341; p_uin=o2731998103; pt4_token=-nJ57ykAQmTjFV54KYD7N9s0*0z0NowSANxmxzlTLFY_; p_skey=3Kx0EJAbPqGASXS1DtcEQ4oSaKczDV3YFObFKNpRyew_; p_luin=o2731998103; p_lskey=00040000e55a748784c4d307f3ca6698653675dfa6d70a0615c0462cf04540d056bd69c54c428d76a9727f63; ts_refer=www.baidu.com/link; yqq_stat=0; yplayer_open=1; yq_playschange=0; yq_playdata=; player_exist=1; ts_last=y.qq.com/portal/player.html; yq_index=6' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: zh-CN,zh;q=0.9,en;q=0.8,und;q=0.7' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36' -H 'accept: */*' -H 'cache-control: no-cache' -H 'authority: u.y.qq.com' -H 'referer: https://y.qq.com/portal/player.html' --compressed | grep -o '\"vkey\"\:\"[a-zA-Z0-9]\{112\}\"' | grep -o '[a-zA-Z0-9]\{112\}')
	echo ${vkey} >> vkey.txt
  wget http://dl.stream.qqmusic.qq.com/C400${songmid}.m4a?guid=8842741264&vkey=${vkey}&uin=7063&fromtag=66
done

for (( i = 0; i < 1236; i++ )); do
	mvlist=$(curl -s "https://c.y.qq.com/mv/fcgi-bin/getmv_by_tag?type=2&year=0&area=0&tag=0&pageno=${i}&pagecount=1000&taglist=1" -H 'authority: c.y.qq.com' -H 'pragma: no-cache' -H 'cache-control: no-cache' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: zh-CN,zh;q=0.9,en;q=0.8,und;q=0.7' -H 'cookie: pgv_pvi=542989312; pgv_si=s4970791936; ptisp=cnc; ptui_loginuin=2731998103; pt2gguin=o2731998103; RK=9M7s/oy1nh; ptcz=f6af2f04959164520ae41420ff519ed25aabf0dc8229afae8fcfb13cd7bdc9ee; pgv_info=ssid=s4620675730; pgv_pvid=8842741264; ts_uid=1573866863; qqmusic_fromtag=66; player_exist=1; yq_index=4; uin=o2731998103; skey=@QFObpbpEt; luin=o2731998103; lskey=00010000ee2db2a0cd2040a9eceafa50923bde4ef747db6c88c188242e7f0d608c7a2d22dfc20c138e932341; p_uin=o2731998103; pt4_token=-nJ57ykAQmTjFV54KYD7N9s0*0z0NowSANxmxzlTLFY_; p_skey=3Kx0EJAbPqGASXS1DtcEQ4oSaKczDV3YFObFKNpRyew_; p_luin=o2731998103; p_lskey=00040000e55a748784c4d307f3ca6698653675dfa6d70a0615c0462cf04540d056bd69c54c428d76a9727f63; ts_refer=xui.ptlogin2.qq.com/cgi-bin/xlogin; yq_playdata=r_99; yq_playschange=0; yplayer_open=0; yqq_stat=0; ts_last=y.qq.com/portal/mv_lib.html' --compressed | grep -o '\"vid\"\:\"[a-zA-Z0-9]\{11\}\"' | grep -o '[a-zA-Z0-9]\{11\}')
	for mv in ${mvlist[@]}; do
		echo ${mv} >> mvlist.txt	
	done	
done

mvlist=$(cat 'mvlist.txt' | grep -o '[a-zA-Z0-9]\{11\}')
for mv in ${mvlist}; do
	you-get https://y.qq.com/n/yqq/mv/v/${mv}.html
done
