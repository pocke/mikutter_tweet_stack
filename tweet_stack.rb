# -*- coding: utf-8 -*-

# Copyright 2013, pocket
# Licensed MIT
# http://opensource.org/licenses/mit-license.php

Plugin.create(:tweet_stack) do

  stack = Array.new
  def sys_mes mes
    Plugin.call(:update, nil, [Message.new(:message => mes, :system => true)])
  end

  command(:tweet_stack,
           name: 'tweet stack',
           condition: lambda{ |opt| true },
           visible: true,
           role: :postbox) do |opt|
    post_val = Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text
    if post_val != '' then
      stack << post_val
      Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text = ''
      sys_mes "「#{stack}」が積まれています"
    else
      if stack[0] then
        Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text = stack.pop
      else
        sys_mes 'stackが空です'
      end
    end
  end

end
