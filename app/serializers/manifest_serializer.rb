# frozen_string_literal: true

class ManifestSerializer < ActiveModel::Serializer
  include RoutingHelper
  include ActionView::Helpers::TextHelper

  attributes :name, :short_name, :description,
             :icons, :theme_color, :background_color,
             :display, :start_url, :scope

  def name
    object.site_title
  end

  def short_name
    object.site_title
  end

  def description
    strip_tags(object.site_description.presence || I18n.t('about.about_mastodon_html'))
  end

  def icons
    [
      {
        src: 'https://toot.cafe/android-chrome-48x48.png',
        sizes: '48x48',
        type: 'image/png',
      }, {
        src: 'https://toot.cafe/android-chrome-72x72.png',
        sizes: '72x72',
        type: 'image/png',
      }, {
        src: 'https://toot.cafe/android-chrome-96x96.png',
        sizes: '96x96',
        type: 'image/png',
      }, {
        src: 'https://toot.cafe/android-chrome-144x144.png',
        sizes: '144x144',
        type: 'image/png',
      }, {
        src: 'https://toot.cafe/android-chrome-192x192.png',
        sizes: '192x192',
        type: 'image/png',
      }, {
        src: 'https://toot.cafe/android-chrome-512x512.png',
        sizes: '512x512',
        type: 'image/png',
      }, {
        src: 'https://toot.cafe/windows-44x44.png',
        sizes: '44x44',
        type: 'image/png',
      }, {
        src: 'https://toot.cafe/windows-50x50.png',
        sizes: '50x50',
        type: 'image/png',
      }, {
        src: 'https://toot.cafe/windows-150x150.png',
        sizes: '150x150',
        type: 'image/png',
      }
    ]
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
    '/web/timelines/home'
  end

  def scope
    root_url
  end
end
