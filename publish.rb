#!/usr/bin/ruby

require 'fileutils'

FileUtils.mkdir('published')

image_filetypes = ['jpg','png','gif','svg']

Dir.entries('.').each do |file|
  FileUtils.cp file, 'published' if image_filetypes.include? file.split('.').pop
end

# FileUtils.rm_rf('published')