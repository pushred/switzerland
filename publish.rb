#!/usr/bin/ruby

require 'fileutils'

image_filetypes = ['.jpg','.png','.gif','.svg']

FileUtils.rm_rf('published')
FileUtils.mkdir('published')

Dir['**/**'].sort.each do |path|

  next if path === 'published'

  if File.directory? path
    FileUtils.mkdir_p File.join 'published', path
  else
    published_path = File.join 'published', File.dirname(path)
    FileUtils.cp path, published_path if image_filetypes.include? File.extname(path)
  end

end