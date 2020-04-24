require 'rails_helper'
require 'byebug'

RSpec.describe 'ユーザー・ログイン管理機能', type: :system do
  describe 'ユーザー管理機能' do
    context '必要項目を入力して登録ボタンを押した場合' do
      before do
        visit new_user_registration_path
        fill_in User.human_attribute_name(:name), with: 'sample01'
        fill_in User.human_attribute_name(:email), with: 'sample_mail01@sample.com'
        fill_in User.human_attribute_name(:password), with: 'sample'
        fill_in User.human_attribute_name(:password_confirmation), with: 'sample'
        click_on 'アカウント登録'
      end
      it "データが保存され、該当ユーザーのマイページに遷移すること" do
        expect(page).to have_content "sample01さんのマイページ"
        expect(page).to have_content '参加・主催予定イベント一覧'
      end
    end
  end
  describe 'ログイン管理機能' do
    before do
      @user = FactoryBot.create(:user)
    end
    context '必要項目を入力してログインボタンを押した場合' do
      before do
        visit new_user_session_path
        fill_in User.human_attribute_name(:email), with: 'sample01@sample.com'
        fill_in User.human_attribute_name(:password), with: 'sample'
        click_button "ログイン"
      end
      it "該当ユーザーのマイページに遷移すること" do
        expect(page).to have_content "#{@user.name}さんのマイページ"
        expect(page).to have_content '参加・主催予定イベント一覧'
      end
    end
    context '入力を誤りログインボタンを押した場合' do
      before do
        visit new_user_session_path
        fill_in User.human_attribute_name(:email), with: 'sample02@sample.com'
        fill_in User.human_attribute_name(:password), with: 'sample'
        click_button "ログイン"
      end
      it "ログイン画面のまま遷移せず、エラーメッセージが表示される。" do
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
  end
end
