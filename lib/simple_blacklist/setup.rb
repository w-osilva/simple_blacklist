require 'fileutils'
require 'simple_blacklist/config'

module SimpleBlacklist
  class Setup

    attr_accessor :base, :config_dir, :initializers_dir, :initializer_file, :blacklist_file

    def initialize
      @base = BLACKLIST_BASE
      @config_dir = File.join(base, BLACKLIST_CONFIG['config_path'])
      @initializers_dir = File.join(@config_dir, BLACKLIST_CONFIG['initializers_path'])
      FileUtils.mkdir_p(@config_dir) unless File.directory?(@config_dir)
      FileUtils.mkdir_p(@initializers_dir) unless File.directory?(@initializers_dir)
      @initializer_file = File.join(initializers_dir, 'simple_blacklist.rb')
      @blacklist_file = File.join(config_dir, 'blacklist.yml')
    end

    def configure
      create_initializer
      create_blacklist
    end

    def create_initializer
      initializer_file_content = <<-FILE
# Define simple_blacklist file
SimpleBlacklist.blacklist_file = File.join(BLACKLIST_BASE, "config", "blacklist.yml")

# Defines masks that will replace the words contained in the simple_blacklist
SimpleBlacklist.mask_denied_words = "****"

# list of letters and characters that can replace the letters
SimpleBlacklist.letters_variations = {
 'a' => ['@', '4'],
 'e' => ['3'],
 'i' => ['1', '|', '!'],
 'o' => ['0'],
 's' => ['$', '5'],
 't' => ['7', '+'],
 'g' => ['6'],
 'b' => ['8']
}
      FILE

      File.open(@initializer_file, 'wb') {|f| f.write(initializer_file_content) } unless File.exist?(@initializer_file)
    end

    def create_blacklist
      blacklist_file_content = <<-FILE
ass
fuck
bitch
      FILE

      File.open(@blacklist_file, 'wb') {|f| f.write(blacklist_file_content) } unless File.exist?(@blacklist_file)
    end

  end
end
