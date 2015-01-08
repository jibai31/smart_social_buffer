require 'rails_helper'

describe Message do

  describe "Twitter message" do
    before(:each) do
      @valid_attr = {social_network_id: 1, content_id: 1}
      @new_message = Message.new(@valid_attr)
    end

    describe "validations" do

      it "must be less than 140 characters" do
        [
          "ABC",
          "This message is exactly 140 characters long. This message is exactly 140 characters long. This message is exactly 140 characters long. Yeah!",
          "This message is exactly 140 characters long. This message is exactly 140 characters long. www.example.com/verylongurl/yesveryverylong with a very long url. Yeah!"
        ].each do |text|
          @new_message.text = text
          expect(@new_message).to be_valid
        end
      end

      it "cannot be over 140 characters" do
        [
          "This message is exactly 140 characters long. This message is exactly 140 characters long. This message is exactly 140 characters long. Yeah!!",
          "This message is exactly 140 characters long. This message is exactly 140 characters long. www.example.com/verylongurl/yesveryverylong with a very long url. Yeah!!"
        ].each do |text|
          @new_message.text = text
          expect(@new_message).not_to be_valid
        end
      end
    end

    describe "#set_default_text" do
      let(:valid_title) { "This is a normal title" }
      let(:long_title)  { "This is a very long title, so long that when concatenated to the URL the total text will be longer than 140 characters" }
      let(:default_url) { "http://www.example.com/verylongurl/yesveryverylong" }

      it "doesn't truncate title if text less than 140 characters" do
        @new_message.set_default_text(valid_title, default_url)
        expect(@new_message.text).to eq "This is a normal title http://www.example.com/verylongurl/yesveryverylong"
      end

      it "truncates title if text over 140 characters" do
        @new_message.set_default_text(long_title, default_url)
        expect(@new_message.text).to eq "This is a very long title, so long that when concatenated to the URL the total text will be longer than 140 characte… http://www.example.com/verylongurl/yesveryverylong"
      end
    end
  end
end
