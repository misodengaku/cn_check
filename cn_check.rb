#!/usr/bin/ruby
#-*- coding: utf-8 -*-

require 'twitter'
require 'yaml'
require 'time'

checkName = "rhe__"
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


begin
	cn_data = Twitter.user(checkName)
	# p cn_data
	#if cn_data["id"] == 1300596066 then
		puts "[#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}]: #{checkName}の生存を確認しました。"
		Twitter.update("[#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}]: #{checkName}の生存を確認しました。")
	#else
	#	puts "[#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}]: #{checkName}はBANされました"
	#	Twitter.update("[#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}]: #{checkName}はBANされました")
	#end
rescue Twitter::Error::NotFound
	Twitter.update("[[#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}]: #{checkName}はBANされました(404)")
rescue Twitter::Error::Forbidden
	Twitter.update("[[#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}]: #{checkName}はBANされました(403)")
end
