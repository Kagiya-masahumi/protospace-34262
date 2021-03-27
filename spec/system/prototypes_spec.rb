require 'rails_helper'

RSpec.describe 'プロトタイプ投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @prototype_title = Faker::Lorem.sentence
    @prototype_catch_copy = Faker::Lorem.sentence
    @prototype_concept = Faker::Lorem.sentence
    
  end


  context 'プロトタイプ投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('New Proto')
      # 投稿ページに移動する
      visit new_prototype_path
      # フォームに情報を入力する
      fill_in 'prototype_title', with: @prototype_title
      fill_in 'prototype_catch_copy', with: @prototype_catch_copy
      fill_in 'prototype_concept', with: @prototype_concept
      attach_file 'プロトタイプの画像', "#{Rails.root}/public/images/sample.png"
      
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Prototype.count }.by(1)
      
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='sample.png']")
      # トップページには先ほど投稿した内容のプロトタイプが存在することを確認する（タイトル）
      expect(page).to have_content(@prototype_title)
      # トップページには先ほど投稿した内容のプロトタイプが存在することを確認する（キャッチコピー）
      expect(page).to have_content(@prototype_catch_copy)
    end
  end

  context 'プロトタイプ投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('New Proto')
    end

    it '投稿に必要な情報が入力されていなければ、投稿できずにそのページにとどまる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('New Proto')
      # 投稿ページに移動する
      visit new_prototype_path
      # フォームに情報を入力する
      fill_in 'prototype_title', with: ''
      fill_in 'prototype_catch_copy', with: ''
      fill_in 'prototype_concept', with: ''
      #送信しても、カウントが変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { Prototype.count }.by(0)
      #新規投稿フォームに戻ったことを確認する
      expect(current_path).to eq("/prototypes") 
    end
  end
end

RSpec.describe 'ツイート編集', type: :system do
  before do
    @prototype1 = FactoryBot.create(:prototype)
    @prototype2 = FactoryBot.create(:prototype)
  end

  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @prototype1.user.email
      fill_in 'パスワード', with: @prototype1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート1に「編集」ボタンがあることを確認する
      get prototype_path(@prototype1)
      #プロトタイプの詳細ページに遷移する
      visit prototype_path(@prototype1)
      expect(page).to have_link '編集する', href: "/prototypes/#{@prototype1.id}/edit"
      # 編集ページへ遷移する
      visit edit_prototype_path(@prototype1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#prototype_title').value
      ).to eq(@prototype1.title)
      # 投稿内容を編集する

      
      fill_in 'prototype_title', with: "#{@prototype1.title}+編集したテキスト"
      # 編集してもPrototypeモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Prototype.count }.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(prototype_path(@prototype1))
      
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      
      expect(page).to have_selector("img[src$='sample.png']")
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content("#{@prototype1.title}+編集したテキスト")
    end
  end

  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      # ツイート2に「編集」ボタンがないことを確認する
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      # ツイート1に「編集」ボタンがないことを確認する
      # ツイート2に「編集」ボタンがないことを確認する
    end
  end 
end


RSpec.describe 'プロトタイプ詳細', type: :system do
  before do
    @prototype = FactoryBot.create(:prototype)
  end
  
  it 'ログインしたユーザーはツイート詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    # ツイートに「詳細」ボタンがあることを確認する
    # 詳細ページに遷移する
    # 詳細ページにツイートの内容が含まれている
    # コメント用のフォームが存在する
  end
  
  it 'ログインしていない状態でツイート詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    # ツイートに「詳細」ボタンがあることを確認する
    # 詳細ページに遷移する
    # 詳細ページにツイートの内容が含まれている
    # フォームが存在しないことを確認する
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
  end
end

