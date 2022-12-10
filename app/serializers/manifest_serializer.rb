# frozen_string_literal: true

class ManifestSerializer < ActiveModel::Serializer
  include RoutingHelper
  include ActionView::Helpers::TextHelper

  ICON_SIZES = %w(
    48
    72
    96
    144
    512
  ).freeze

  attributes :id, :name, :short_name,
             :icons, :theme_color, :background_color,
             :display, :start_url, :scope,
             :share_target, :shortcuts

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
    ICON_SIZES.map do |size|
      {
        src: "/android-chrome-#{size}x#{size}.png",
        sizes: "#{size}x#{size}",
        type: 'image/png',
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
    ]
  end
end
