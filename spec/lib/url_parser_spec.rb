require 'spec_helper'
require './lib/url_parser'

describe UrlParser do
  
  describe "extract_url" do
    it "extracts the http url in text" do
      expect(UrlParser.extract_url(
        "This is a normal text http://archive.railsforum.com/viewtopic.php?id=12258. Over the bridge."
      )).to eq "http://archive.railsforum.com/viewtopic.php?id=12258"
      expect(UrlParser.extract_url(
        "This is a normal text http://archive.railsforum.com/viewtopic.php?id=12258 . Over the bridge."
      )).to eq "http://archive.railsforum.com/viewtopic.php?id=12258"
      expect(UrlParser.extract_url(
        "This is a normal text http://archive.railsforum.com/viewtopic.php? the bridge."
      )).to eq "http://archive.railsforum.com/viewtopic.php"
      expect(UrlParser.extract_url(
        "This is a normal text http://archive.railsforum.com/viewtopic.php?id=12258&hide=true Over."
      )).to eq "http://archive.railsforum.com/viewtopic.php?id=12258&hide=true"
      expect(UrlParser.extract_url(
        "This is a normal text http://railsforum.com/viewtopic.php?id=12258. Over the bridge."
      )).to eq "http://railsforum.com/viewtopic.php?id=12258"
      expect(UrlParser.extract_url(
        "This is a normal text http://archive.railsforum.com. Over the bridge."
      )).to eq "http://archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal text http://archive.railsforum.com/ Over the bridge."
      )).to eq "http://archive.railsforum.com/"
      expect(UrlParser.extract_url(
        "This is a normal text http://archive.railsforum.com/. Over the bridge."
      )).to eq "http://archive.railsforum.com/"
      expect(UrlParser.extract_url(
        "This is a normal text http://archive.railsforum.com"
      )).to eq "http://archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal text http://railsforum.com"
      )).to eq "http://railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal text (http://archive.railsforum.com)"
      )).to eq "http://archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal (text http://archive.railsforum.com)"
      )).to eq "http://archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal (text http://archive.railsforum.com/viewtopic.php?id=12258)"
      )).to eq "http://archive.railsforum.com/viewtopic.php?id=12258"
    end

    it "extracts the https url in text" do
      expect(UrlParser.extract_url(
        "This is a normal text https://archive.railsforum.com/viewtopic.php?id=12258. Over the bridge."
      )).to eq "https://archive.railsforum.com/viewtopic.php?id=12258"
      expect(UrlParser.extract_url(
        "This is a normal text https://archive.railsforum.com/viewtopic.php?id=12258 . Over the bridge."
      )).to eq "https://archive.railsforum.com/viewtopic.php?id=12258"
      expect(UrlParser.extract_url(
        "This is a normal text https://archive.railsforum.com/viewtopic.php? the bridge."
      )).to eq "https://archive.railsforum.com/viewtopic.php"
      expect(UrlParser.extract_url(
        "This is a normal text https://archive.railsforum.com/viewtopic.php?id=12258&hide=true Over."
      )).to eq "https://archive.railsforum.com/viewtopic.php?id=12258&hide=true"
      expect(UrlParser.extract_url(
        "This is a normal text https://railsforum.com/viewtopic.php?id=12258. Over the bridge."
      )).to eq "https://railsforum.com/viewtopic.php?id=12258"
      expect(UrlParser.extract_url(
        "This is a normal text https://archive.railsforum.com. Over the bridge."
      )).to eq "https://archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal text https://archive.railsforum.com/ Over the bridge."
      )).to eq "https://archive.railsforum.com/"
      expect(UrlParser.extract_url(
        "This is a normal text https://archive.railsforum.com/. Over the bridge."
      )).to eq "https://archive.railsforum.com/"
      expect(UrlParser.extract_url(
        "This is a normal text https://archive.railsforum.com"
      )).to eq "https://archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal text https://railsforum.com"
      )).to eq "https://railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal text (https://archive.railsforum.com)"
      )).to eq "https://archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal (text https://archive.railsforum.com)"
      )).to eq "https://archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal (text https://archive.railsforum.com/viewtopic.php?id=12258)"
      )).to eq "https://archive.railsforum.com/viewtopic.php?id=12258"
    end

    it "extracts the bare url in text" do
      expect(UrlParser.extract_url(
        "This is a normal text archive.railsforum.com/viewtopic.php?id=12258. Over the bridge."
      )).to eq "archive.railsforum.com/viewtopic.php?id=12258"
      expect(UrlParser.extract_url(
        "This is a normal text archive.railsforum.com/viewtopic.php?id=12258 . Over the bridge."
      )).to eq "archive.railsforum.com/viewtopic.php?id=12258"
      expect(UrlParser.extract_url(
        "This is a normal text archive.railsforum.com/viewtopic.php?id=12258&hide=true Over."
      )).to eq "archive.railsforum.com/viewtopic.php?id=12258&hide=true"
      expect(UrlParser.extract_url(
        "This is a normal text railsforum.com/viewtopic.php?id=12258. Over the bridge."
      )).to eq "railsforum.com/viewtopic.php?id=12258"
      expect(UrlParser.extract_url(
        "This is a normal text archive.railsforum.com. Over the bridge."
      )).to eq "archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal text archive.railsforum.com/ Over the bridge."
      )).to eq "archive.railsforum.com/"
      expect(UrlParser.extract_url(
        "This is a normal text archive.railsforum.com/. Over the bridge."
      )).to eq "archive.railsforum.com/"
      expect(UrlParser.extract_url(
        "This is a normal text archive.railsforum.com"
      )).to eq "archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal text railsforum.com"
      )).to eq "railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal text (archive.railsforum.com)"
      )).to eq "archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal (text archive.railsforum.com)"
      )).to eq "archive.railsforum.com"
      expect(UrlParser.extract_url(
        "This is a normal (text archive.railsforum.com/viewtopic.php?id=12258)"
      )).to eq "archive.railsforum.com/viewtopic.php?id=12258"
    end

    it "should not pass those (I need to fix the regex)" do
      expect(UrlParser.extract_url(
        "This is a normal text railsforum/viewtopic.php"
      )).to eq "railsforum/viewtopic.php" # actual nil

      expect(UrlParser.extract_url(
        "This is a normal text http://archive.railsforum.c"
      )).to eq "http://archive.railsforum.c" # actual http://archive.railsforum

      expect(UrlParser.extract_url(
        "This is a normal text railsforum.cc"
      )).to eq "railsforum.cc" # actual nil (cc is not a valid domain extension)
    end
  end
end
