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
