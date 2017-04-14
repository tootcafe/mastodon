object false

node(:name)             { Setting.site_title }
node(:short_name)       { Setting.site_title }
node(:description)      { strip_tags(Setting.site_description.presence || I18n.t('about.about_mastodon_html')) }
node(:icons)            { [{ src: '/android-chrome-48x48.png', sizes: '48x48', type: 'image/png' }, { src: '/android-chrome-72x72.png', sizes: '72x72', type: 'image/png' }, { src: '/android-chrome-96x96.png', sizes: '96x96', type: 'image/png' }, { src: '/android-chrome-144x144.png', sizes: '144x144', type: 'image/png' }, { src: '/android-chrome-192x192.png', sizes: '192x192', type: 'image/png' }, { src: '/android-chrome-512x512.png', sizes: '512x512', type: 'image/png' }] }
node(:theme_color)      { '#282c37' }
node(:background_color) { '#f1ebff' }
node(:display)          { 'standalone' }
node(:start_url)        { '/web/timelines/home' }
node(:scope)            { root_url }
