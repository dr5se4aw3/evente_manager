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

    end
    context 'イベント新規作成画面' do
      before do
        visit new_event_path
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
    context 'イベント一覧画面' do
      before do
        today = DateTime.now
        @event1 = FactoryBot.create(:event, title:"サンプルイベント１",started_at: today+1, closed_at: today+1, release: true, user: @user)
        @event2 = FactoryBot.create(:event, title:"サンプルイベント２",started_at: today+5, closed_at: today+6, release: true, user: @user)
        @event3 = FactoryBot.create(:event, title:"サンプルイベント３",started_at: today+2, closed_at: today+3, release: true, user: @user)
        visit events_path
      end
      it "作成したイベントが一覧画面に、開始日時の昇順で表示されていること" do
        expect(all('.event_infomation')[0]).to have_content(@event1.title)
        expect(all('.event_infomation')[1]).to have_content(@event3.title)
        expect(all('.event_infomation')[2]).to have_content(@event2.title)
      end
    end
    context 'イベント詳細画面' do
      before do
        @user2 = FactoryBot.create(:user, name:"村山さん", email:"sample002@sample.com")
        today = DateTime.now
        @event1 = FactoryBot.create(:event, title:"サンプルイベント１",started_at: today+1, closed_at: today+1, release: true, user: @user)
        @event2 = FactoryBot.create(:event, title:"サンプルイベント１",started_at: today+1, closed_at: today+1, release: true, user: @user2)
      end
      it "作成したイベントの情報が表示されていること" do
        visit event_path(@event1)
        expect(page).to have_content(@event1.title)
        expect(page).to have_content(@event1.user.name)
        expect(page).to have_content(@event1.started_at)
        expect(page).to have_content(@event1.closed_at)
        expect(page).to have_content(@event1.venue_name)
        expect(page).to have_content(@event1.venue_address)
        expect(page).to have_content(@event1.venue_url)
      end
      it "自身が作成したイベントを編集できること" do
        visit event_path(@event1)
        click_on 'Edit'
        #タイトル
        fill_in Event.human_attribute_name(:title), with: "（更新あり）"
        #開始日時
        select "2020" , from: 'event[started_at(1i)]'
        select "5" , from: 'event[started_at(2i)]'
        select "2" , from: 'event[started_at(3i)]'
        select "12" , from: 'event[started_at(4i)]'
        select "00" , from: 'event[started_at(5i)]'
        #終了日時
        select "2020" , from: 'event[closed_at(1i)]'
        select "5" , from: 'event[closed_at(2i)]'
        select "2" , from: 'event[closed_at(3i)]'
        select "14" , from: 'event[closed_at(4i)]'
        select "00" , from: 'event[closed_at(5i)]'
        #イベント会場
        fill_in Event.human_attribute_name(:venue_name), with: "（更新あり）"
        fill_in Event.human_attribute_name(:venue_address), with: "（更新あり）"
        fill_in Event.human_attribute_name(:venue_url), with: "（更新あり）"
        #備考
        fill_in Event.human_attribute_name(:note), with: "（更新あり）"
        click_button "更新する"
        expect(page).to have_content("（更新あり）")
      end
      it "他のユーザーが作成したイベントに参加でき、また参加解除ができること" do
        visit event_path(@event2)
        click_on "参加する"
        expect(page).to have_content("イベントに参加しました")
        visit event_path(@event2)
        click_on "参加を解除する"
        expect(page).to have_content("イベントの参加を取り消しました")
      end
    end

  end
end
