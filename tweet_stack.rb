# -*- coding: utf-8 -*-

# Copyright 2013, pocket
# Licensed MIT
# http://opensource.org/licenses/mit-license.php

Plugin.create(:tweet_stack) do

  stack = Array.new

  def sys_mes msg
    Plugin.call(:update, nil, [Message.new(:message => msg, :system => true)])
  end

  command(:tweet_stack,
           name: 'tweet stack',
           condition: lambda{ |opt| true },
           visible: true,
           role: :postbox) do |opt|
    text = Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text
    if text.empty? then
      if stack.empty? then
        sys_mes 'stackが空です'
      else
        Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text = stack.pop
      end
    else
      stack.push text
      Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text = ''
      sys_mes "「#{stack}」が積まれています"
    end
  end

end
