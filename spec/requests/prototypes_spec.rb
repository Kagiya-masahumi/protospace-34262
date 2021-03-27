require 'rails_helper'
describe PrototypesController, type: :request do

  before do
    @prototype = FactoryBot.create(:prototype)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのプロトタイプのタイトルが存在する' do 
      get root_path
      expect(response.body).to include(@prototype.title)
    end

    it 'indexアクションにリクエストするとレスポンスに投稿済みのプロトタイプのキャッチコピーが存在する' do 
      get root_path
      expect(response.body).to include(@prototype.catch_copy)
    end

    it 'indexアクションにリクエストするとレスポンスに投稿済みのプロトタイプの画像URLが存在する' do 
      get root_path
      expect(page).to have_selector("img[src$='sample.png']")
    end
  end


  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get prototype_path(@prototype)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのプロトタイプのタイトルが存在する' do 
      get prototype_path(@prototype)
      expect(response.body).to include(@prototype.title)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのプロトタイプのキャッチコピーが存在する' do 
      get prototype_path(@prototype)
      expect(response.body).to include(@prototype.catch_copy)
    end

    it 'showアクションにリクエストするとレスポンスに投稿済みのプロトタイプのコンセプトが存在する' do 
      get prototype_path(@prototype)
      expect(response.body).to include(@prototype.concept)
    end

  end 
end