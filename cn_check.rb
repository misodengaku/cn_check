#!/usr/bin/ruby
#-*- coding: utf-8 -*-

require 'twitter'
require 'yaml'
require 'time'

checkName = ["cn", "rhe__", "se4k", "cn_court_", "cn_scaffold_"]
#result = []
#validId = [1300596066]


#設定ファイルロード
begin
	settings = YAML::load(open("./cn_check.conf"))
	Twitter.configure do |config|
		config.consumer_key		= settings["consumer_key"]
		config.consumer_secret		= settings["consumer_secret"]
		config.oauth_token			= settings["oauth_token"]
		config.oauth_token_secret	= settings["oauth_token_secret"]
	end
rescue
	puts "[#{Time.now}]: [ERROR] config file load failed."
end

text = "[#{Time.now.strftime("%Y/%m/%d %H:%M")}] \n"
checkName.each { |sname|
	begin
		data = Twitter.user(sname)
		text = text + "#{sname} 生存\n"
		#result.push("生存")
		# puts "[#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}]: #{sname}の生存を確認しました。"
	rescue Twitter::Error::NotFound
		text = text + "#{sname} 凍結？(404)\n"
		#result.push("凍結？(404)")
	rescue Twitter::Error::Forbidden
		text = text + "#{sname} 凍結？(403)\n"
		#result.push("凍結？(403)")
	end
}


Twitter.update(text)