require 'spec_helper'

describe SimpleBlacklist do
  before(:all) do
    @setup = SimpleBlacklist::Setup.new
    @setup.configure
    require @setup.initializer_file
  end

  after(:all) do
    FileUtils.rm_rf @setup.config_dir
  end

  it 'has a version number' do
    expect(SimpleBlacklist::VERSION).not_to be nil
  end

  describe "#sanitize" do

    subject(:text_simple) { 'kiss my ass' }
    it 'a word contained in the blacklist is replaced' do
      expect(SimpleBlacklist.sanitize(text_simple)).to eq('kiss my ****')
    end

    subject(:text_special_char) { 'kiss my @$$' }
    it 'a word written with special characters is replaced' do
      expect(SimpleBlacklist.sanitize(text_special_char)).to eq('kiss my ****')
    end

    subject(:text_with_word_like) { 'kiss my ass assassin' }
    it 'a similar word (not contained in the blacklist) can not be replaced' do
      expect(SimpleBlacklist.sanitize(text_with_word_like)).to eq('kiss my **** assassin')
    end

    subject(:text_special_char_with_word_like) { 'kiss my @$$ @$$assin' }
    it 'a similar word with special characters (not contained in the blacklist) can not be replaced' do
      expect(SimpleBlacklist.sanitize(text_special_char_with_word_like)).to eq('kiss my **** @$$assin')
    end

  end
end
