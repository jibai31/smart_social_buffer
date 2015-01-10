# encoding: UTF-8
module HasContents
  extend ActiveSupport::Concern

  included do
    has_many :contents, dependent: :destroy
  end

  def contents_with_messages
    contents.includes(:category, :messages).includes(messages: :social_network)
  end

end
