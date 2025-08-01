# frozen_string_literal: true

class ManifestSerializer < ActiveModel::Serializer
  include InstanceHelper
  include RoutingHelper
  include ActionView::Helpers::TextHelper

  attributes :id, :name, :short_name,
             :icons, :theme_color, :background_color,
             :display, :start_url, :scope,
             :share_target, :shortcuts,
             :prefer_related_applications, :related_applications

  def id
    # This is set to `/home` because that was the old value of `start_url` and
    # thus the fallback ID computed by Chrome:
    # https://developer.chrome.com/blog/pwa-manifest-id/
    '/home'
  end

  def name
    "Toot Café"
  end

  def short_name
    "Toot Café"
  end

  def icons
    SiteUpload::ANDROID_ICON_SIZES.map do |size|
      src = app_icon_path(size.to_i)
      src = URI.join(root_url, src).to_s if src.present?

      {
        src: src || frontend_asset_url("icons/android-chrome-#{size}x#{size}.png"),
        sizes: "#{size}x#{size}",
        type: 'image/png',
        purpose: 'any maskable',
      }
    end
  end

  def theme_color
    '#282c37'
  end

  def background_color
    '#f1ebff'
  end

  def display
    'standalone'
  end

  def start_url
    '/'
  end

  def scope
    '/'
  end

  def share_target
    {
      url_template: 'share?title={title}&text={text}&url={url}',
      action: 'share',
      method: 'GET',
      enctype: 'application/x-www-form-urlencoded',
      params: {
        title: 'title',
        text: 'text',
        url: 'url',
      },
    }
  end

  def shortcuts
    [
      {
        name: 'Compose new post',
        url: '/publish',
      },
      {
        name: 'Notifications',
        url: '/notifications',
      },
      {
        name: 'Explore',
        url: '/explore',
      },
    ]
  end

  def prefer_related_applications
    true
  end

  def related_applications
    [
      {
        platform: 'play',
        url: 'https://play.google.com/store/apps/details?id=org.joinmastodon.android',
        id: 'org.joinmastodon.android',
      },
      {
        platform: 'itunes',
        url: 'https://apps.apple.com/us/app/mastodon-for-iphone/id1571998974',
        id: 'id1571998974',
      },
      {
        platform: 'f-droid',
        url: 'https://f-droid.org/en/packages/org.joinmastodon.android/',
        id: 'org.joinmastodon.android',
      },
    ]
  end
end
