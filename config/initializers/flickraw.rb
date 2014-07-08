flickraw_config = YAML.load(ERB.new(File.read("config/flickr.yml")).result)
FlickRaw.api_key = flickraw_config['key']
FlickRaw.shared_secret = flickraw_config['secret']
