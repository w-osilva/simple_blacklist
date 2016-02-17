require "simple_blacklist/setup"
require "simple_blacklist/version"

module SimpleBlacklist
  @@blacklist_file ||= File.join(BLACKLIST_BASE, BLACKLIST_CONFIG['config_path'], 'blacklist.yml')
  @@letters_variations ||= {}
  @@mask_denied_words ||= "****"
  @@blacklist ||= []

  module_function
  def blacklist_file=(file)
    raise "Given blacklist_file is not a File" unless File.exist? file
    @@blacklist_file = file
  end

  def blacklist_file
    @@blacklist_file
  end

  def letters_variations=(list)
    raise "Given letters_variations is not a Hash" unless list.instance_of? Hash
    @@letters_variations = list
  end

  def letters_variations
    @@letters_variations
  end

  def mask_denied_words=(mask)
    raise "Given mask_denied_words is not a String" unless mask.instance_of? String
    @@mask_denied_words = mask
  end

  def mask_denied_words
    @@mask_denied_words
  end

  def reload_blacklist
    f = File.open(@@blacklist_file, 'rb')
    content = f.read
    @@blacklist = content.split(/\W+/)
    @@blacklist.map!(&:downcase)
  end

  def sanitize(text)
    reload_blacklist
    words = text.split(/([[:space:]]|[.,;:]|[[:blank:]])/)
    words.each do |word|
      word_replaced = replace_letters(word)
      if @@blacklist.include? word_replaced.downcase
        if word_replaced.downcase == word.downcase
          text.gsub!(/(\b([#{word.split('').join("][")}])\b)/i, @@mask_denied_words)
        else
          if text=~/(\B([#{word.split('').join("][")}])\B)/i
            text.gsub!(/(\B([#{word.split('').join("][")}])\B)/i, @@mask_denied_words)
          else
            text.gsub!(/([#{word.split('').join("][")}])/i, @@mask_denied_words)
          end
        end
      end
    end
    text
  end

  def replace_letters(word)
    word_replaced = word.clone
    chars = word.split('')
    chars.each do |char|
      @@letters_variations.each do |(key,list_chars)|
        if list_chars.include? char.downcase
          word_replaced.gsub!(/[#{char}]/, "#{key}")
        end
      end
    end
    word_replaced
  end

end
