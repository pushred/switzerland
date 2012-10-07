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

Given /^I have a folder containing images$/ do
  FileUtils.cp File.join(ROOT, EXAMPLE_IMAGE), TEST_DIRECTORY
end

When /^I publish content$/ do
  `ruby #{PUBLISH_SCRIPT}`
  raise('Script not found') unless $?.success?
end

Then /^the images will be included$/ do
  File.exists?( File.join TEST_DIRECTORY, 'published', EXAMPLE_IMAGE ).should === true
end