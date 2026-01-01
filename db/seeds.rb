# db/seeds.rb

puts "== Seeding start =="

ActiveRecord::Base.transaction do
  # ユーザー
  owner = User.find_or_create_by!(email: "owner@example.com") do |u|
    u.password = "password"
    u.name = "オーナー太郎"
  end

  other_owner = User.find_or_create_by!(email: "other_owner@example.com") do |u|
    u.password = "password"
    u.name = "別オーナー花子"
  end

  guest = User.find_or_create_by!(email: "guest@example.com") do |u|
    u.password = "password"
    u.name = "ゲスト次郎"
  end

  # ルーム（施設）
  rooms = []

  rooms << Room.find_or_create_by!(title: "東京の空が見える部屋") do |r|
    r.user = owner
    r.address = "東京都渋谷区1-1-1"
    r.description = "空が見える。静か。"
    r.price_per_night = 12000
  end

  rooms << Room.find_or_create_by!(title: "駅近の東京ルーム") do |r|
    r.user = owner
    r.address = "東京都新宿区2-2-2"
    r.description = "駅近で便利。"
    r.price_per_night = 9000
  end

  rooms << Room.find_or_create_by!(title: "京都の古民家ステイ") do |r|
    r.user = other_owner
    r.address = "京都府京都市3-3-3"
    r.description = "古民家でゆったり。"
    r.price_per_night = 15000
  end

  room_with_image = Room.find_or_create_by!(title: "画像ありルーム") do |r|
    r.user = owner
    r.address = "東京都品川区4-4-4"
    r.description = "画像テスト用。"
    r.price_per_night = 8000
  end

  room_without_image = Room.find_or_create_by!(title: "画像なしルーム") do |r|
    r.user = owner
    r.address = "東京都目黒区5-5-5"
    r.description = "デフォルト画像確認用。"
    r.price_per_night = 7000
  end

  # 画像attach
  image_path = Rails.root.join("db", "seed_assets", "room.jpg")
  if File.exist?(image_path) && !room_with_image.image.attached?
    room_with_image.images.attach(
      io: File.open(image_path),
      filename: "room.jpg",
      content_type: "image/jpeg"
    )
    puts "Attached image to: #{room_with_image.title}"
  end

  # 予約
  check_in = Date.current + 7
  check_out = Date.current + 9

  Reservation.find_or_create_by!(
    user: guest,
    room: rooms.first,
    check_in_on: check_in,
    check_out_on: check_out
  ) do |res|
    res.guests_count = 2
  end

  Reservation.find_or_create_by!(
    user: guest,
    room: rooms.last,
    check_in_on: check_in,
    check_out_on: check_out
  ) do |res|
    res.guests_count = 1
  end
end

puts "== Seeding done =="
