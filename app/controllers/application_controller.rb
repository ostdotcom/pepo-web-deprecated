class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_request_from_bot_flag

  # Sanitize params
  include Sanitizer
  before_action :sanitize_params
  after_action :handle_whitelisted_api_cookies
  after_action :set_response_headers

  include CookieConcern
  include ApplicationHelper

  # Page not found action
  #
  def not_found
    res = {
      error: 'page_not_found',
      error_display_text: 'Page not found',
      http_code: GlobalConstant::ErrorCode.not_found
    }
    @response = Result::Base.error(res)
    render_error_response_for(@response)
  end

  # ELB Health Checker
  #
  def health_checker
    render plain: '', :status => 200
  end

  private

  # Get user agent
  #
  def http_user_agent
    request.env['HTTP_USER_AGENT'].to_s
  end

  # set bot request flag in params
  #
  def set_request_from_bot_flag
    res = http_user_agent.match(/\b(Baidu|Baiduspider|Gigabot|Googlebot|thefind|webmeup-crawler.com|libwww-perl|lwp-trivial|msnbot|SiteUptime|Slurp|ZIBB|wget|ia_archiver|ZyBorg|bingbot|AdsBot-Google|AhrefsBot|FatBot|shopstyle|pinterest.com|facebookexternalhit|Twitterbot|crawler.sistrix.net|PolyBot|rogerbot|Pingdom|Mediapartners-Google|bitlybot|BlapBot|Python|www.socialayer.com|Sogou|Scrapy|ShopWiki|Panopta|websitepulse|NewRelicPinger|Sailthru|JoeDog|SocialWire|CCBot|yacybot|Halebot|SNBot|SEOENGWorldBot|SeznamBot|libfetch|QuerySeekerSpider|A6-Indexer|PAYONE|GrapeshotCrawler|curl|ShowyouBot|NING|kraken|MaxPointCrawler|efcrawler|YisouSpider|BingPreview|MJ12bot)\b/i)
    params[:is_bot] = res.present? ? 1 : 0
  end

  # Set response headers
  #
  def set_response_headers
    response.headers["X-Content-Type-Options"] = 'nosniff'
    response.headers["X-Frame-Options"] = 'SAMEORIGIN'
    response.headers["X-XSS-Protection"] = '1; mode=block'
    response.headers["Content-Type"] = 'text/html; charset=utf-8'
  end

  # Sanitize params
  #
  def sanitize_params
    sanitize_params_recursively(params)
  end

  def handle_whitelisted_api_cookies
    new_api_cookies = request.cookies[GlobalConstant::Cookie.new_api_cookie_key.to_sym]
    return if new_api_cookies.blank?
    whitelisted_api_cookies = [GlobalConstant::Cookie.user_cookie_name, GlobalConstant::Cookie.last_used_env_cookie_name, GlobalConstant::Cookie.device_verification_toast_cookie_name, GlobalConstant::Cookie.secure_data_access_cookie_name]
    whitelisted_api_cookies.each do |key|
      whitelisted_cookie = new_api_cookies[key]
      if whitelisted_cookie.present? and whitelisted_cookie.is_a?(Hash)
        cookies[key.to_sym] = whitelisted_cookie
      end
    end
  end

  def render_error_response_for(service_response)

    http_code = service_response.http_code

    @page_assets_data = {specific_js_required: 0}

    # Clean critical data
    service_response.data = {}

    if request.xhr?
      (render plain: Oj.dump(service_response.to_json, mode: :compat), status: http_code) and return
    else
      response.headers['Content-Type'] = 'text/html'
      render file: "public/422.html", layout: false, status: http_code and return
    end

  end

  def delete_cookie(cookie_name)
    cookies.delete(
      cookie_name.to_sym,
      domain: GlobalConstant::PepoApi.cookie_domain,
      secure: Rails.env.production?,
      same_site: :strict
    )
  end

end
