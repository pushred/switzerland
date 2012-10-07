Feature: Manage Content

    As a writer,
    I want to manage my content with files and folders
    So that I can use my own software for writing

    Scenario: Images

        Given I have a folder containing images
        When I publish content
        Then the images will be included
