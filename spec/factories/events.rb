FactoryBot.define do
  factory :event do
    title{"サンプルイベント"}
    started_at{"2020/05/01-12:00"}
    closed_at{"2020/05/01-14:00"}
    venue_name{"大田区産業プラザpio"}
    venue_address{"東京都大田区南蒲田1丁目20-20"}
    venue_url{"https://www.pio-ota.net/"}
    note{"システムスペックてすとです。"}
    association :user
  end
end
