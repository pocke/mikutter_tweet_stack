# -*- coding: utf-8 -*-

Plugin.create(:tweet_stack) do
  stack = nil
  class String
    def sys_mes
      Plugin.call(:update, nil, [Message.new(:message => self, :system => true)])
    end
  end
  command(:tweet_stack,
          name: 'tweet stack',
          condition: lambda{ |opt| true },
          visible: true,
          role: :postbox) do |opt|
    post_val = Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text

    if stack == nil then
      if post_val != '' then
        stack = post_val
        Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text = ''
        "「#{stack}」をstackしました。".sys_mes
      else
        '投稿ボックスが空なのでstackできません。'.sys_mes
      end
    else
      if post_val == '' then
        Plugin.create(:gtk).widgetof(opt.widget).widget_post.buffer.text = stack
        stack = nil
      else
        '投稿ボックスが空でないのでstackを戻せません。'.sys_mes
      end
    end
  end
end
