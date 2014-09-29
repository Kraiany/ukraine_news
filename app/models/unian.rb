class Unian < Article
  def self.base_url
    'http://www.unian.ua'
  end

  def unique_identifier_string
    if match = /\d+/.match(relative_url)
      "Unian-#{match[0]}"
    else
      return nil
    end
  end
end
