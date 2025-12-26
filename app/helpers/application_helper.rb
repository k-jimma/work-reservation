module ApplicationHelper
  ROOM_FALLBACK_URL = "https://rails-02-sample.herokuapp.com/assets/room/default-image-4e0ac6b8d01335b5b22fe6586af13644ae51dddb6aeabf35b9174e80f13cd09d.png".freeze
  USER_FALLBACK_URL = "https://rails-02-sample.herokuapp.com/assets/common/default-avatar-7a6cbfd7993e89f24bfc888f4a035a83c6f1428b8bdc47eed9095f2799a40153.png".freeze

  def room_image_tag(room = nil, **opts)
    image_tag(ROOM_FALLBACK_URL, { alt: "room", loading: "lazy" }.merge(opts))
  end

  def user_icon_tag(user = nil, **opts)
    image_tag(USER_FALLBACK_URL, { alt: "user", loading: "lazy" }.merge(opts))
  end

  def yen(amount)
    return "-" if amount.blank?
    "¥#{number_with_delimiter(amount)}"
  end
end
