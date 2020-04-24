require 'rails_helper'
require 'byebug'

RSpec.describe 'イベント管理機能', type: :system do
  describe 'イベント作成' do
    before do
      @user = FactoryBot.create(:user)
      visit new_user_session_path
      fill_in User.human_attribute_name(:email), with: 'sample01@sample.com'
      fill_in User.human_attribute_name(:password), with: 'sample'
      click_button "ログイン"
      visit new_event_path
    end
    context 'イベント新規作成画面' do
      before do
        @title = "サンプルイベント"
        @venue_name = "大田区産業プラザpio"
        @venue_address = "東京都大田区南蒲田1丁目20-20"
        @venue_url = "https://www.pio-ota.net/"
        @note = "システムスペックてすとです。"
      end
      it "正しく入力して登録ボタン押すと該当イベントの詳細ページに遷移する" do
        #タイトル
        fill_in Event.human_attribute_name(:title), with: @title
        #開始日時
        select "2020" , from: 'event[started_at(1i)]'
        select "5" , from: 'event[started_at(2i)]'
        select "1" , from: 'event[started_at(3i)]'
        select "12" , from: 'event[started_at(4i)]'
        select "00" , from: 'event[started_at(5i)]'
        #終了日時
        select "2020" , from: 'event[closed_at(1i)]'
        select "5" , from: 'event[closed_at(2i)]'
        select "1" , from: 'event[closed_at(3i)]'
        select "14" , from: 'event[closed_at(4i)]'
        select "00" , from: 'event[closed_at(5i)]'
        #イベント会場
        fill_in Event.human_attribute_name(:venue_name), with: @venue_name
        fill_in Event.human_attribute_name(:venue_address), with: @venue_address
        fill_in Event.human_attribute_name(:venue_url), with: @venue_url
        #備考
        fill_in Event.human_attribute_name(:note), with: @note
        click_button "登録する"

        expect(page).to have_content(@title)
      end
      it "入力が不足して登録ボタン押すと遷移せずエラーメッセージが表示される" do
        #タイトル
        fill_in Event.human_attribute_name(:title), with: ""
        #開始日時
        select "2020" , from: 'event[started_at(1i)]'
        select "5" , from: 'event[started_at(2i)]'
        select "1" , from: 'event[started_at(3i)]'
        select "12" , from: 'event[started_at(4i)]'
        select "00" , from: 'event[started_at(5i)]'
        #終了日時
        select "2020" , from: 'event[closed_at(1i)]'
        select "5" , from: 'event[closed_at(2i)]'
        select "1" , from: 'event[closed_at(3i)]'
        select "14" , from: 'event[closed_at(4i)]'
        select "00" , from: 'event[closed_at(5i)]'
        #イベント会場
        fill_in Event.human_attribute_name(:venue_name), with: ""
        fill_in Event.human_attribute_name(:venue_address), with: ""
        fill_in Event.human_attribute_name(:venue_url), with: ""
        #備考
        fill_in Event.human_attribute_name(:note), with: ""
        click_button "登録する"

        expect(page).to have_content("イベント名を入力してください")
        expect(page).to have_content("会場名を入力してください")
        expect(page).to have_content("会場住所を入力してください")
        expect(page).to have_content("会場URLを入力してください")

      end

    end
  end
end
