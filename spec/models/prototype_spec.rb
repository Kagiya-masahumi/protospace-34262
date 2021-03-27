require 'rails_helper'

RSpec.describe Prototype, type: :model do
  before do
    @prototype = FactoryBot.build(:prototype)
    #@item.image = fixture_file_upload('public/image/output-image1.png')
  end

  describe 'プロトタイプの保存' do
    context 'プロトタイプが投稿できる場合' do

      it '必須項目に適切な値が存在すれば投稿できる' do
        expect(@prototype).to be_valid
      end

    end

    context 'ツイートが投稿できない場合' do

      it 'テキストが空では投稿できない' do
        @prototype.title = ''
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include("Title can't be blank")
      end   

      it 'ユーザーが紐付いていなければ投稿できない' do
        @prototype.user = nil
        @prototype.valid?
        expect(@prototype.errors.full_messages).to include('User must exist')
      end

    end

  end
end