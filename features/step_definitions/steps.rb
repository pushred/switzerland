require 'nokogiri'

ROOT = FileUtils.pwd
TEST_DIRECTORY = File.join ROOT, 'example'
PUBLISH_SCRIPT = File.join ROOT, 'publish.rb'
EXAMPLE_IMAGE = 'alps.jpg'

Before do
  FileUtils.mkdir TEST_DIRECTORY
  Dir.chdir TEST_DIRECTORY
end

After do
  FileUtils.rm_rf TEST_DIRECTORY
end

Given /^a folder containing images$/ do
  FileUtils.cp File.join(ROOT, EXAMPLE_IMAGE), TEST_DIRECTORY
end

Given /^.*a folder containing Markdown files.*$/ do |example_markdown|
  File.open('example.md', 'w') do |file|
    file.write example_markdown
    file.close
  end
end

Given /^a tree of folders$/ do
  FileUtils.mkdir_p 'fruits/citrus/tangerines'
  FileUtils.cp File.join(ROOT, EXAMPLE_IMAGE), 'fruits/citrus/tangerines'
end

When /^I publish content$/ do
  `ruby #{PUBLISH_SCRIPT}`
  raise('Script not found') unless $?.success?
end

Then /^the images will be included$/ do
  File.exists?( File.join TEST_DIRECTORY, 'published', EXAMPLE_IMAGE ).should === true
end

Then /^that tree will be preserved$/ do
  File.exists?( File.join TEST_DIRECTORY, 'published', 'fruits', 'citrus', 'tangerines', EXAMPLE_IMAGE ).should === true
end

Then /^the Markdown will be converted into HTML$/ do
  example_markdown = File.join TEST_DIRECTORY, 'published', 'example.html'

  File.exists?(example_markdown).should === true

  File.open(example_markdown, 'r') do |markup|
    Nokogiri::HTML.parse(markup).css('h1').length.should > 0
  end
end
