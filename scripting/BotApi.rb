require 'mechanize'

module BotApi
  class Facebook
    def initialize()
      @agent = Mechanize.new
      @agent.redirect_ok = true
      @form = []
      @is_logged = false
    end

    private
    def check_cookie(c)
      c.each do |x|
        if x.to_s.include?('c_user=')
          return true
        end
      end
      return false
    end

    public
    def get_uri
      @agent.page.uri.to_s
    end

    def get_links
      @agent.page.links
    end

    def clear_cookies
      @agent.cookie_jar.clear!
      nil
    end

    def get_cookies
      @agent.cookies
    end

    def login(user, pass)
      if not @is_logged
        @agent.get("https://m.facebook.com/")
        @user = user
        @pass = pass
        @form = @agent.page.form #@agent.page.forms[0]
        @form['email'] = @user
        @form['pass'] = @pass
        @form.submit
        if check_cookie(get_cookies)
          @agent.get("https://m.facebook.com/")
          @is_logged = true
          true
        else
            false
        end
      else
        true
      end
    end

    def logout
      if @is_logged
        get_links.each do |link|
          link.click if link.href.include?("logout")
        end
        !check_cookie(get_cookies)
      else
        false
      end
    end

    def status_code
      @agent.page.code
    end

    def post(msg)
      @form = @agent.page.form_with(:action => /composer/)
      @form['xc_message'] = msg
      @btn = @form.button_with(:value => "Kirim")
      @btn = @form.button_with(:value => "Post") if @btn.nil?
      @agent.submit(@form, @btn)
      nil
    end
  end
  #class Twitter
  #class Instagram
  #and so on...
end
